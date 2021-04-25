import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/successes.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loaded.dart';
import 'package:museo_zuccante/feature/items/presentation/states/items_loading.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class ItemsPage extends StatefulWidget {
  final goToList;

  ItemsPage({
    Key key,
    @required this.goToList,
  }) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();

    updateItemsIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ItemsUpdaterBloc, ItemsUpdaterState>(
        listener: (context, state) {
          reactToUpdaterState(state);
        },
        child: BlocBuilder<ItemsWatcherBloc, ItemsWatcherState>(
          builder: (context, state) {
            if (state is ItemsWatcherLoadSuccess) {
              return ItemsLoadedState(
                items: state.items,
                goToList: widget.goToList,
              );
            } else if (state is ItemsWatcherFailure) {
              return MZFailureView(
                failure: state.failure,
                refresh: updateItems,
              );
            }
            return ItemsLoadingState();
          },
        ),
      ),
    );
  }

  void updateItems() {
    BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
  }

  void updateItemsIfNeeded() {
    BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItemsIfNeeded());
  }

  void reactToUpdaterState(ItemsUpdaterState state) {
    if (state is ItemsUpdaterFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.failure.localizedDescription(context)),
      ));
    } else if (state is ItemsUpdaterSuccess &&
        state.success is SuccessWithUpdate) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Aggiornato'),
      ));
    }
  }
}

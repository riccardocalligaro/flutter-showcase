import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/successes.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';
import 'package:museo_zuccante/feature/home/states/items_loaded.dart';
import 'package:museo_zuccante/feature/home/states/items_loading.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              if (state.items.isEmpty) {
                return ItemsLoadingState();
              }

              final highlightedItems =
                  state.items.where((i) => i.highlighted).toList();

              final items = state.items.where((i) => !i.highlighted).toList();

              return ItemsLoadedState(
                items: items,
                highlightedItems: highlightedItems,
                goToList: () {},
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';

import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/presentation/states/widget/item_vertical_card.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/items/presentation/watcher/items_watcher_bloc.dart';

class ItemsListPage extends StatefulWidget {
  final Widget rooms;

  ItemsListPage({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsWatcherBloc, ItemsWatcherState>(
      builder: (context, state) {
        if (state is ItemsWatcherLoadSuccess) {
          return buildLoaded(items: state.items);
        } else if (state is ItemsWatcherFailure) {
          return MZFailureView(
            failure: state.failure,
            refresh: updateItems,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildLoaded({
    @required List<ItemDomainModel> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Text(
            'All exibitions',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildItemsList(items: items),
      ],
    );
  }

  Widget buildItemsList({
    @required List<ItemDomainModel> items,
  }) {
    if (items.length >= 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemVerticalCard(
                item: item,
                fromHome: false,
              );
            },
          ),
          SizedBox(
            height: 180,
            child: widget.rooms,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            itemCount: items.length - 2,
            itemBuilder: (context, index) {
              final item = items[index + 2];
              return ItemVerticalCard(
                item: item,
                fromHome: false,
              );
            },
          ),
        ],
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemVerticalCard(
            item: item,
            fromHome: false,
          );
        },
      );
    }
  }

  void goToItemPage(ItemDomainModel itemDomainModel) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ItemPage(
    //       item: itemDomainModel,
    //     ),
    //   ),
    // );
  }

  void updateItems() {
    BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/states/mz_empty_view.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/item/presentation/item_page.dart';
import 'package:museo_zuccante/feature/items/presentation/states/widget/item_vertical_card.dart';
import 'package:museo_zuccante/feature/items/presentation/updater/items_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';

import 'bloc/room_items_bloc.dart';

class RoomPage extends StatefulWidget {
  final String name;
  final String roomId;
  final bool disableHero;

  RoomPage({
    Key key,
    @required this.roomId,
    @required this.name,
    this.disableHero = false,
  }) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoomItemsBloc>(context)
        .add(GetRoomItems(roomId: widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        brightness: Brightness.dark,
      ),
      body: BlocBuilder<RoomItemsBloc, RoomItemsState>(
        builder: (context, state) {
          if (state is RoomItemsLoaded) {
            if (state.items.isEmpty) {
              return MZEmptyView(
                onPressed: updateRooms,
              );
            } else {
              return buildItemsList(items: state.items);
            }
          } else if (state is RoomItemsFailure) {
            return MZFailureView(
              failure: state.failure,
              refresh: updateRooms,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void updateRooms() {
    BlocProvider.of<RoomsUpdaterBloc>(context).add(UpdateRooms());
    BlocProvider.of<ItemsUpdaterBloc>(context).add(UpdateItems());
  }

  Widget buildItemsList({
    @required List<ItemDomainModel> items,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        updateRooms();
      },
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemVerticalCard(
            item: item,
            fromHome: false,
            disableHero: widget.disableHero,
          );
        },
      ),
    );
  }

  void goToItemPage(ItemDomainModel itemDomainModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemPage(
          item: itemDomainModel,
        ),
      ),
    );
  }
}

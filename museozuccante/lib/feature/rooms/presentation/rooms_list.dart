import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';

import 'package:museo_zuccante/feature/rooms/presentation/state/rooms_loaded.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/watcher/rooms_watcher_bloc.dart';

class RoomsList extends StatefulWidget {
  RoomsList({Key key}) : super(key: key);

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RoomsWatcherBloc>(context).add(WatchAllStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomsWatcherBloc, RoomsWatcherState>(
        listener: (context, state) {
          if (state is RoomsWatcherLoadSuccess && state.rooms.isEmpty) {
            updateRooms();
          }
        },
        builder: (context, state) {
          if (state is RoomsWatcherLoadSuccess) {
            // return Text(state.rooms.length.toString());
            if (state.rooms.isEmpty) {
              return buildLoading();
            }

            return RoomsLoaded(rooms: state.rooms);
          } else if (state is RoomsWatcherFailure) {
            return MZFailureView(
              failure: state.failure,
              refresh: updateRooms,
            );
          }

          return buildLoading();
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void updateRooms() {
    BlocProvider.of<RoomsUpdaterBloc>(context).add(UpdateRooms());
  }
}

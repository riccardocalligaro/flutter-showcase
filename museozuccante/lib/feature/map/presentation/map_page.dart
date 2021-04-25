import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/presentation/customization/mz_colors.dart';
import 'package:museo_zuccante/core/presentation/states/mz_failure_view.dart';
import 'package:museo_zuccante/core/presentation/states/mz_loading_view.dart';
import 'package:museo_zuccante/feature/map/presentation/widget/zoom_container.dart';
import 'package:museo_zuccante/feature/rooms/domain/model/room_domain_model.dart';
import 'package:museo_zuccante/feature/rooms/presentation/updater/rooms_updater_bloc.dart';
import 'package:museo_zuccante/feature/rooms/presentation/watcher/rooms_watcher_bloc.dart';

import 'model/map_object.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<RoomsWatcherBloc>(context).add(WatchAllStarted());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RoomsWatcherBloc, RoomsWatcherState>(
        builder: (context, state) {
          if (state is RoomsWatcherLoadSuccess) {
            // return Text(state.rooms.length.toString());
            if (state.rooms.isEmpty) {
              return MZLoadingView();
            }

            return RoomsMap(rooms: state.rooms);
          } else if (state is RoomsWatcherFailure) {
            return MZFailureView(
              failure: state.failure,
              refresh: updateRooms,
            );
          }

          return MZLoadingView();
        },
      ),
    );
    return Scaffold(
      body: Center(
        child: ZoomContainer(
          zoomLevel: 4,
          imageProvider: Image.asset("assets/map/ground_floor.png").image,
          objects: [
            MapObject(
              room: RoomDomainModel(
                id: '7a057219-3dee-402f-9e22-5e8c41b8760c',
                title: 'Aula',
                floor: 1,
                number: 1,
                offsetX: 5,
                offsetY: 5,
              ),
              child: Icon(
                Icons.room,
                size: 33,
                color: MZColors.primary,
              ),
              offset: Offset(0.3, 0),
              size: Size(10, 10),
            ),
          ],
        ),
      ),
    );
  }

  void updateRooms() {
    BlocProvider.of<RoomsUpdaterBloc>(context).add(UpdateRooms());
  }
}

class RoomsMap extends StatelessWidget {
  final List<RoomDomainModel> rooms;

  const RoomsMap({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZoomContainer(
        zoomLevel: 4,
        imageProvider: Image.asset("assets/map/ground_floor.png").image,
        objects: rooms.map(
          (r) {
            return MapObject(
              child: Icon(
                Icons.room,
                size: 33,
                color: MZColors.primary,
              ),
              offset: Offset(r.offsetX, r.offsetY),
              room: r,
              size: Size(10, 10),
            );
          },
        ).toList(),
      ),
    );
  }
}

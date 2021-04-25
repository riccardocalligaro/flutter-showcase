import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:museo_zuccante/core/presentation/customization/mz_colors.dart';
import 'package:museo_zuccante/feature/items/presentation/items_page.dart';
import 'package:museo_zuccante/feature/list/list_page.dart';
import 'package:museo_zuccante/feature/settings/settings_page.dart';

import 'map/presentation/map_page.dart';

class MZNavigator extends StatefulWidget {
  const MZNavigator({Key key}) : super(key: key);

  @override
  _MZNavigatorState createState() => _MZNavigatorState();
}

class _MZNavigatorState extends State<MZNavigator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ItemsPage(
            goToList: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          ListPage(),
          MapPage(),
          SettingsPage(),
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: MZColors.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 0) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ));
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ));
        }
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.map),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:memos/core/core_container.dart';
import '../../core/data/memos_database.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Reset db'),
            onTap: () async {
              final MemosDatabase database = sl();
              await database.clearAllTables();
            },
          ),
        ],
      ),
    );
  }
}

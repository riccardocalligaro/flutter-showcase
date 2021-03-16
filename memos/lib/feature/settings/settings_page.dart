import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/core/infrastructure/m_notifications.dart';
import 'package:memos/feature/login/login_page.dart';
import '../../core/data/memos_database.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Reset database'),
            onTap: () async {
              final MemosDatabase database = sl();
              await database.clearAllTables();
            },
          ),
          ListTile(
            title: Text('Schedule notification'),
            onTap: () {
              final MNotifications mNotifications = sl();
              mNotifications.scheduleNotification(
                eventId: 1,
                title: 'PRova',
                message: 'Rembeber this.',
                scheduledTime: tz.TZDateTime.from(
                  DateTime.now().add(Duration(seconds: 10)),
                  tz.local,
                ),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

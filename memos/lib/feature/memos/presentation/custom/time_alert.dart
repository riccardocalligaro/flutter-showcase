import 'package:flutter/material.dart';

class SelectNotificationsTimeAlertDialog extends StatefulWidget {
  final Duration beforeNotification;

  SelectNotificationsTimeAlertDialog({
    Key key,
    @required this.beforeNotification,
  }) : super(key: key);

  @override
  _SelectNotificationsTimeAlertDialogState createState() =>
      _SelectNotificationsTimeAlertDialogState();
}

class _SelectNotificationsTimeAlertDialogState
    extends State<SelectNotificationsTimeAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Seleziona'),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile(
                title: Text(
                  'Al momento',
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(milliseconds: 0),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              ),
              RadioListTile(
                title: Text(
                  '{m} minutes before'.replaceAll('{m}', '30'),
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(minutes: 30),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              ),
              RadioListTile(
                title: Text(
                  '{m} hour before'.replaceAll('{m}', '1'),
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(minutes: 60),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              ),
              RadioListTile(
                title: Text(
                  '{m} hours before'.replaceAll('{m}', '2'),
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(minutes: 120),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              ),
              RadioListTile(
                title: Text(
                  '{m} hours before'.replaceAll('{m}', '12'),
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(hours: 12),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              ),
              RadioListTile(
                title: Text(
                  'A day before',
                  style: TextStyle(fontSize: 13),
                ),
                value: Duration(hours: 24),
                groupValue: widget.beforeNotification,
                onChanged: (Duration duration) {
                  Navigator.pop(context, duration);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

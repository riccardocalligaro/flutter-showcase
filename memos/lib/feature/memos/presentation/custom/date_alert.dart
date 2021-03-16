import 'package:flutter/material.dart';

class SelectDateDialog extends StatefulWidget {
  SelectDateDialog({Key key}) : super(key: key);

  @override
  _SelectDateDialogState createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<SelectDateDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select a date'),
      content: Container(
        height: 240,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.today),
                title: Text('Today'),
                onTap: () {
                  Navigator.pop(
                    context,
                    DateTime.now().add(Duration(
                      minutes: 30,
                    )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_forward),
                title: Text('Tomorrow'),
                onTap: () {
                  Navigator.pop(
                    context,
                    DateTime.now().add(Duration(
                      days: 1,
                    )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.next_week),
                title: Text('Next week'),
                onTap: () {
                  Navigator.pop(
                    context,
                    DateTime.now().add(
                      Duration(
                        days: 7,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text('Custom date'),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2018),
                    lastDate: DateTime.utc(2030),
                  ).then((date) {
                    Navigator.pop(context, date);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

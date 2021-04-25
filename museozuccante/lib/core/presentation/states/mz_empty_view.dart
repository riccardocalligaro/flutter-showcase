import 'package:flutter/material.dart';

class MZEmptyView extends StatelessWidget {
  final String text;
  final IconData icon;
  final String buttonText;
  final Function onPressed;

  const MZEmptyView({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(
              icon ?? Icons.hourglass_empty,
              size: 80,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              text ?? 'Nessun elemento',
              textAlign: TextAlign.center,
            ),
          ),
          if (onPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(
                onPressed: onPressed,
                child: Text(buttonText ?? 'Aggiorna'),
              ),
            )
        ],
      ),
    );
  }
}

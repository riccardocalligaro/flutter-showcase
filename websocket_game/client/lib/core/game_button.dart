import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String content;
  final Color color;
  final VoidCallback onTap;

  const GameButton({
    Key key,
    @required this.content,
    this.color,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 22),
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        content.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
      onPressed: onTap,
    );
  }
}

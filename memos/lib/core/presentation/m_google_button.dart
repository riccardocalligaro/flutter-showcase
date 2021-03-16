import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Button in the login and registration with facebook
class MGoogleButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const MGoogleButton(
    this.text, {
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 17,
          ),
          SvgPicture.asset('assets/google.svg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: 0.5,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xffD8D8D8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      onPressed: onTap,
    );
  }
}

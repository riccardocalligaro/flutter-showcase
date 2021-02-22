import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Trasparent app bar without elevation or shadows
/// that is used for the steps in onboarding
class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GestureTapCallback onTap;
  final String text;
  final bool showBack;

  const MAppBar({
    Key key,
    @required this.onTap,
    @required this.text,
    this.showBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: showBack
          ? IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onTap,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

class MZLoadingView extends StatelessWidget {
  const MZLoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

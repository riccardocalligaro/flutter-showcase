import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;

  const CustomShimmer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        color: Colors.grey,
        child: child,
      );
    }
    return Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[300],
    );
  }
}

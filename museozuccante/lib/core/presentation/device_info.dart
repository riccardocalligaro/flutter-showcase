import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/presentation/styles.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:sized_context/sized_context.dart';

bool get isDesktop =>
    UniversalPlatform.isWindows ||
    UniversalPlatform.isMacOS ||
    UniversalPlatform.isLinux;

bool get isDesktopOrWeb => isDesktop || kIsWeb == true;

bool get isMobile => !isDesktopOrWeb;

bool isMobileWidth(BuildContext context) => context.widthPx > Sizes.largePhone;

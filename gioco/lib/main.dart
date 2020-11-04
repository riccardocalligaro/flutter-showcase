import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gioco/core/extension/g_colors.dart';
import 'package:gioco/game/game_container.dart';
import 'package:gioco/game/presentation/game_page.dart';

void main() async {
  // Needed if you initialized shared preferences before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // init the dependency injection
  await GameContainer.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(ColorsGame());
}

/// Simple game to test your reflexes and select the right color
class ColorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GColors.primary,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GamePage(),
    );
  }
}

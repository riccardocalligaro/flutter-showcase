import 'package:flutter/material.dart';
import 'package:gioco/core/extension/colors_ext.dart';
import 'package:gioco/game/game_container.dart';
import 'package:gioco/game/presentation/game_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GameContainer.init();

  runApp(ColorsGame());
}

/// Simple game to test your reflexes and select the right
/// color
class ColorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors game',
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

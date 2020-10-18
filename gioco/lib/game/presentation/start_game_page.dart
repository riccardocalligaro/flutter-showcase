import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gioco/game/domain/usecase/get_record_points_usecase.dart';
import 'package:gioco/game/presentation/widget/animations/start_game_animated_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../game_container.dart';

class StartGamePage extends StatefulWidget {
  final GetRecordPointsUseCase getRecordPointsUseCase;
  final VoidCallback startGame;

  const StartGamePage({
    Key key,
    @required this.getRecordPointsUseCase,
    @required this.startGame,
  }) : super(key: key);

  @override
  _StartGamePageState createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  bool showStart = true;

  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 64, 16.0, 0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'COLORS',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'GAME',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'HIGH SCORE: ${widget.getRecordPointsUseCase.execute(NoParams()).getOrElse(() => 0)}',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 82.0),
              child: StartGameAnimatedCircle(
                getQuestionUseCase: sl(),
                startGame: () {
                  widget.startGame();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // audioPlayer.stop();

    super.dispose();
  }
}

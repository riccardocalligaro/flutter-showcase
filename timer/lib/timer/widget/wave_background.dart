import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class WaveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color(0xff5A189A).withOpacity(0.4),
            Color(0xff7B2CBF).withOpacity(0.4),
            Color(0xff9D4EDD).withOpacity(0.4),
          ],
          [
            Color(0xff10002B).withOpacity(0.8),
            Color(0xff240046).withOpacity(0.8),
            Color(0xff3C096C).withOpacity(0.8),
          ],
          [
            // purple color palette
            Color(0xff10002b),
            Color(0xff240046),
            Color(0xff3c096c),
            Color(0xff5a189a),
            Color(0xff7b2cbf),
            Color(0xff7b2cbf),
            Color(0xff9d4edd),
            Color(0xffc77dff),
            Color(0xffe0aaff),
          ],
        ],
        durations: [1, 2, 3],
        // durations: [
        //   32000,
        //   21000,
        //   30000,
        // ],
        heightPercentages: [0.03, 0.01, 0.02],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: Colors.blue[50],
    );
  }
}

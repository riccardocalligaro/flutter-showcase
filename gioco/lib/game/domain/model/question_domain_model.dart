import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gioco/game/presentation/widget/section.dart';

class QuestionDomainModel {
  /// The correct color generated from a random
  /// material color
  Color generatedColor;

  /// Random generated answers, not in a specific order
  /// One of them is the correct one
  List<Section> possibleAnswers;

  /// Time in millseconds that the user has to tap
  /// the correct color
  int timeToAnswer;

  /// How many points the question gives
  /// This can be a number from 1 to 5 (based on the difficulty)
  int points;

  QuestionDomainModel({
    @required this.generatedColor,
    @required this.possibleAnswers,
    @required this.timeToAnswer,
    @required this.points,
  }) : assert(generatedColor != null &&
            possibleAnswers != null &&
            timeToAnswer != null &&
            points != null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuestionDomainModel &&
        o.generatedColor == generatedColor &&
        listEquals(o.possibleAnswers, possibleAnswers) &&
        o.timeToAnswer == timeToAnswer &&
        o.points == points;
  }

  @override
  int get hashCode {
    return generatedColor.hashCode ^
        possibleAnswers.hashCode ^
        timeToAnswer.hashCode ^
        points.hashCode;
  }

  @override
  String toString() {
    return 'QuestionDomainModel(generatedColor: $generatedColor, possibleAnswers: $possibleAnswers, timeToAnswer: $timeToAnswer, points: $points)';
  }
}

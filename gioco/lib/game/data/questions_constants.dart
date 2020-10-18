class QuestionsConstants {
  /// 4 possible correct answers, 3 seconds to answer, 1 point
  static const int DIFFICULTY_EASY = 1;

  /// 6 possible correct answers, 3 seconds to answer, 2 points
  static const int DIFFICULTY_MEDIUM = 5;

  /// 6 possible correct answers, 2 seconds to answer, 5 points
  static const int DIFFICULTY_HARD = 9;

  /// 8 possible correct answers, 2 seconds to answer, 10 points
  static const int DIFFICULTY_EXTREME = 14;

  static const int DIFFICULTY_ONLY_AI = 40;

  static const String MAX_SCORE_KEY = 'maxScore';

  static const int EASY_POINTS = 1;
  static const int EASY_TIME_TO_ANSWER = 3000;
  static const int EASY_ANSWERS = 4;

  static const int MEDIUM_POINTS = 2;
  static const int MEDIUM_TIME_TO_ANSWER = 3000;
  static const int MEDIUM_ANSWERS = 6;

  static const int HARD_POINTS = 5;
  static const int HARD_TIME_TO_ANSWER = 2000;
  static const int HARD_ANSWERS = 6;

  static const int EXTREME_POINTS = 10;
  static const int EXTREME_TIME_TO_ANSWER = 1000;
  static const int EXTREME_ANSWERS = 8;

  static const int AI_POINTS = 50;
  static const int AI_TIME_TO_ANSWER = 1500;
  static const int AI_ANSWERS = 25;
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gioco/game/data/questions_constants.dart';
import 'package:gioco/game/data/questions_repository_impl.dart';
import 'package:gioco/game/domain/repository/questions_repository.dart';

void main() {
  group('correct question generation', () {
    final QuestionsRepository questionsRepository = QuestionsRepositoryImpl(
      sharedPreferences: null,
    );

    List questionRList = [];

    for (int i = 0; i < 100; i++) {
      questionRList.add(questionsRepository.getRandomQuestion(currentScore: 0));
    }

    test('avoid duplicate colors in possible answers', () {});

    test('correct answer is in possible answers', () {
      for (int i = 0; i < 100; i++) {
        final questionR = questionRList[i];

        expect(questionR.isRight(), true);

        final question = questionR.getOrElse(() => null);

        expect(
            question.possibleAnswers
                .map((e) => e.color)
                .toList()
                .contains(question.generatedColor),
            true);
      }
    });

    test('high score is saved in the shared preferences', () {});
  });

  group('correct question difficulty', () {
    final questionsRepository = QuestionsRepositoryImpl(
      sharedPreferences: null,
    );

    bool checkEasyConditions(Tuple3 params) {
      return params.value1 == QuestionsConstants.EASY_POINTS &&
          params.value2 == QuestionsConstants.EASY_TIME_TO_ANSWER &&
          params.value3 == QuestionsConstants.EASY_ANSWERS;
    }

    bool checkMediumConditions(Tuple3 params) {
      return params.value1 == QuestionsConstants.MEDIUM_POINTS &&
          params.value2 == QuestionsConstants.MEDIUM_TIME_TO_ANSWER &&
          params.value3 == QuestionsConstants.MEDIUM_ANSWERS;
    }

    bool checkHardConditions(Tuple3 params) {
      return params.value1 == QuestionsConstants.HARD_POINTS &&
          params.value2 == QuestionsConstants.HARD_TIME_TO_ANSWER &&
          params.value3 == QuestionsConstants.HARD_ANSWERS;
    }

    bool checkExtremeConditions(Tuple3 params) {
      return params.value1 == QuestionsConstants.EXTREME_POINTS &&
          params.value2 == QuestionsConstants.EXTREME_TIME_TO_ANSWER &&
          params.value3 == QuestionsConstants.EXTREME_ANSWERS;
    }

    bool checkAIConditions(Tuple3 params) {
      return params.value1 == QuestionsConstants.AI_POINTS &&
          params.value2 == QuestionsConstants.AI_TIME_TO_ANSWER &&
          params.value3 == QuestionsConstants.AI_ANSWERS;
    }

    test('easy difficulty', () {
      int score = 1;
      var params = questionsRepository.getQuestionDifficultyParams(score);

      expect(checkEasyConditions(params), true);

      expect(
          checkEasyConditions(
              questionsRepository.getQuestionDifficultyParams(4)),
          true);

      expect(
          checkEasyConditions(
              questionsRepository.getQuestionDifficultyParams(5)),
          false);
    });

    test('hard difficulty', () {
      expect(
          checkHardConditions(
              questionsRepository.getQuestionDifficultyParams(8)),
          false);

      expect(
          checkHardConditions(
              questionsRepository.getQuestionDifficultyParams(9)),
          true);

      expect(
          checkHardConditions(
              questionsRepository.getQuestionDifficultyParams(10)),
          true);

      expect(
          checkMediumConditions(
              questionsRepository.getQuestionDifficultyParams(14)),
          false);
    });

    test('medium difficulty', () {
      expect(
          checkMediumConditions(
              questionsRepository.getQuestionDifficultyParams(4)),
          false);

      expect(
          checkMediumConditions(
              questionsRepository.getQuestionDifficultyParams(5)),
          true);

      expect(
          checkMediumConditions(
              questionsRepository.getQuestionDifficultyParams(8)),
          true);

      expect(
          checkMediumConditions(
              questionsRepository.getQuestionDifficultyParams(9)),
          false);
    });

    test('extreme difficulty', () {
      expect(
          checkExtremeConditions(
              questionsRepository.getQuestionDifficultyParams(13)),
          false);

      expect(
          checkExtremeConditions(
              questionsRepository.getQuestionDifficultyParams(14)),
          true);

      expect(
          checkExtremeConditions(
              questionsRepository.getQuestionDifficultyParams(30)),
          true);

      expect(
          checkExtremeConditions(
              questionsRepository.getQuestionDifficultyParams(40)),
          false);
    });

    test('ai difficulty', () {
      expect(
          checkAIConditions(
              questionsRepository.getQuestionDifficultyParams(39)),
          false);

      expect(
          checkAIConditions(
              questionsRepository.getQuestionDifficultyParams(40)),
          true);

      expect(
          checkAIConditions(
              questionsRepository.getQuestionDifficultyParams(589)),
          true);

      expect(
          checkAIConditions(
              questionsRepository.getQuestionDifficultyParams(999)),
          true);
    });
  });
}

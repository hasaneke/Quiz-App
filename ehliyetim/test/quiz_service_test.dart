import 'package:ehliyetim/features/quiz/data/model/service/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IQuizService quizService;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    quizService = QuizService();
  });
  test('Fetch quizzes', () async {
    final quizList = await quizService.fetchQuestions();
    print(quizList);
  });
}

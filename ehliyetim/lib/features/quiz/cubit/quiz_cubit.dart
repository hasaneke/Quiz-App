import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/features/quiz/data/model/service/quiz_service.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final IQuizService quizService;
  QuizCubit(this.quizService) : super(const QuizState()) {
    initialize();
  }

  void initialize() async {
    emit(state.copyWith(quizStatus: QuizStatus.loading));
    final questions = await quizService.fetchQuestions();

    emit(state.copyWith(questions: questions, quizStatus: QuizStatus.loaded));
    _startTimer();
  }

  void updatePageIndex(int i) async {
    emit(state.copyWith(currentIndex: i));
  }

  Future<void> _startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(timer: state.timer + 1));
    });
  }

  bool revealAnswers(int i) {
    if (state.questions[state.currentIndex].answers?[i] == state.questions[state.currentIndex].correctAnswer) {
      return true;
    }
    return false;
  }
}

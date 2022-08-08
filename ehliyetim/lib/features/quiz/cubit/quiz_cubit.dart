import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/features/quiz/data/model/service/quiz_service.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final IQuizService quizService;
  late final Timer _timer;
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

  void _startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(timer: state.timerCount + 1));
    });
  }

  void stopTimer() async {
    _timer.cancel();
  }

  void revealAnswer(int i) {
    final option = state.questions[state.currentIndex].answers?[i];
    if (option?.substring(0, 1) == state.questions[state.currentIndex].correctAnswer) {
      emit(state.copyWith(correctsCount: state.correctsCount + 1));
    } else {
      emit(state.copyWith(wrongCounts: state.wrongCounts + 1));
    }
    _updateTheList(i);
  }

  void _updateTheList(int i) {
    emit(state.copyWith(
        questions: state.questions.map((e) {
      if (state.questions[state.currentIndex].questionCount == e.questionCount) {
        return e.copyWith(isAnswered: true, pickedAnswerIndex: i);
      } else {
        return e;
      }
    }).toList()));
  }
}

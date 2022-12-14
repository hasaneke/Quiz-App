part of 'quiz_cubit.dart';

class QuizState extends Equatable {
  const QuizState(
      {this.questions = const [],
      this.quizStatus = QuizStatus.loading,
      this.currentIndex = 0,
      this.answeredCounts = 0,
      this.correctsCount = 0,
      this.wrongCounts = 0,
      this.timerCount = 0});

  final List<QuestionModel> questions;
  final QuizStatus quizStatus;
  final int answeredCounts;
  final int correctsCount;
  final int wrongCounts;
  final int currentIndex;
  final int timerCount;
  @override
  List<Object?> get props =>
      [currentIndex, answeredCounts, quizStatus, questions, correctsCount, wrongCounts, timerCount];

  QuizState copyWith(
      {List<QuestionModel>? questions,
      int? answeredCounts,
      QuizStatus? quizStatus,
      int? correctsCount,
      int? currentIndex,
      int? wrongCounts,
      int? timer}) {
    return QuizState(
      timerCount: timer ?? timerCount,
      currentIndex: currentIndex ?? this.currentIndex,
      answeredCounts: answeredCounts ?? this.answeredCounts,
      questions: questions ?? this.questions,
      quizStatus: quizStatus ?? this.quizStatus,
      correctsCount: correctsCount ?? this.correctsCount,
      wrongCounts: wrongCounts ?? this.wrongCounts,
    );
  }
}

enum QuizStatus {
  loading,
  loaded,
  failed,
}

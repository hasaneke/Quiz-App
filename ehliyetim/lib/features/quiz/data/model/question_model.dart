import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable(createToJson: false)
class QuestionModel {
  String? questionCount;
  List<String>? contents;
  int? questionBodyIndexIncontents;
  List<String>? answers;
  bool isAnswered;
  int? pickedAnswerIndex;
  String? correctAnswer;

  QuestionModel(
      {this.questionCount,
      this.contents,
      this.pickedAnswerIndex,
      this.questionBodyIndexIncontents,
      this.answers,
      this.correctAnswer,
      this.isAnswered = false});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  QuestionModel copyWith({
    String? questionCount,
    int? pickedAnswerIndex,
    List<String>? contents,
    int? questionBodyIndexIncontents,
    List<String>? answers,
    bool? isAnswered,
    String? correctAnswer,
  }) {
    return QuestionModel(
      pickedAnswerIndex: pickedAnswerIndex ?? this.pickedAnswerIndex,
      questionCount: questionCount ?? this.questionCount,
      contents: contents ?? this.contents,
      questionBodyIndexIncontents: questionBodyIndexIncontents ?? this.questionBodyIndexIncontents,
      answers: answers ?? this.answers,
      isAnswered: isAnswered ?? this.isAnswered,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }
}

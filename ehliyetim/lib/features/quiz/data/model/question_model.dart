import 'package:json_annotation/json_annotation.dart';
part 'question_model.g.dart';

@JsonSerializable(createToJson: false)
class QuestionModel {
  String? questionCount;
  List<String>? contents;
  int? questionBodyIndexIncontents;
  List<String>? answers;
  String? correctAnswer;

  QuestionModel(
      {this.questionCount, this.contents, this.questionBodyIndexIncontents, this.answers, this.correctAnswer});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);
}

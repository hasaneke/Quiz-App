import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable(createToJson: false)
class BaseModel {
  String? url;
  String? quizName;
  List<QuestionModel>? questionObjects;

  BaseModel({this.url, this.quizName, this.questionObjects});

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);
}

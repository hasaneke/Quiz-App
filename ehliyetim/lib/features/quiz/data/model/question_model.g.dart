// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) => QuestionModel(
      questionCount: json['questionCount'] as String?,
      contents: (json['contents'] as List<dynamic>?)?.map((e) => e as String).toList(),
      questionBodyIndexIncontents: json['questionBodyIndexIncontents'] as int?,
      answers: (json['answers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String?,
    );

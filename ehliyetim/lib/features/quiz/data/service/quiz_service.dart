import 'dart:convert';

import 'package:ehliyetim/features/quiz/data/model/base_model.dart';
import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/product/consts/assets_paths.dart';
import 'package:flutter/services.dart';

abstract class IQuizService {
  Future<List<QuestionModel>?> fetchQuestions() async {
    return null;
  }
}

class QuizService implements IQuizService {
  @override
  Future<List<QuestionModel>?> fetchQuestions() async {
    final String response = await rootBundle.loadString(AssetPaths.jsonFile.path);
    final data = await json.decode(response);
    final baseModel = BaseModel.fromJson(data);
    return baseModel.questionObjects;
  }
}

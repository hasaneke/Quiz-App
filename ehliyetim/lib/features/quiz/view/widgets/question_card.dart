import 'package:ehliyetim/features/quiz/cubit/quiz_cubit.dart';
import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/features/quiz/view/widgets/styles_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionCard({
    Key? key,
    required this.questionModel,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: questionModel.isAnswered,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_question(context), _options(context)],
      ),
    );
  }

  StyledContainer _options(BuildContext context) {
    return StyledContainer(
      context: context,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, i) => context.emptySizedHeightBoxLow,
        itemCount: questionModel.answers?.length ?? 0,
        itemBuilder: (ctx, i) => _OptionItem(questionModel: questionModel, index: i),
      ),
    );
  }

  StyledContainer _question(BuildContext context) {
    return StyledContainer(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: questionModel.contents
                  ?.map((e) => Text(
                        e,
                        style: Theme.of(context).textTheme.titleSmall,
                      ))
                  .toList() ??
              [],
        ));
  }
}

class _OptionItem extends StatelessWidget with ParseAnswer {
  const _OptionItem({
    Key? key,
    required this.questionModel,
    required this.index,
  }) : super(key: key);

  final QuestionModel questionModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<QuizCubit>().revealAnswer(index),
      child: Container(
        decoration: BoxDecoration(
          color: questionModel.isAnswered
              ? (parsFirstLetter(questionModel.answers?[index] ?? '') == questionModel.correctAnswer
                  ? context.appTheme.colorScheme.onTertiary
                  : (questionModel.pickedAnswerIndex == index
                      ? context.appTheme.errorColor
                      : context.appTheme.colorScheme.onPrimary))
              : context.appTheme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: context.onlyLeftPaddingLow,
        margin: context.onlyTopPaddingLow,
        height: context.dynamicHeight(.08),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            questionModel.answers?[index] ?? '',
          ),
        ),
      ),
    );
  }
}

mixin ParseAnswer {
  String parsFirstLetter(String text) => text.substring(0, 1);
}

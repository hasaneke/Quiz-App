import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/features/quiz/view/widgets/styles_container.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;
  const QuestionCard({
    Key? key,
    required this.questionModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StyledContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: questionModel.contents
                  ?.map((e) => Text(
                        e,
                        style: Theme.of(context).textTheme.titleSmall,
                      ))
                  .toList() ??
              [],
        )),
        Expanded(
          child: StyledContainer(
            child: ListView.separated(
                separatorBuilder: (_, i) => const SizedBox(
                      height: 10,
                    ),
                itemCount: questionModel.answers?.length ?? 0,
                itemBuilder: (ctx, i) => ListTile(
                      title: Text(
                        questionModel.answers?[i] ?? '',
                      ),
                    )),
          ),
        )
      ],
    );
  }
}

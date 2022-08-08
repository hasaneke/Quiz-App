import 'package:ehliyetim/features/quiz/cubit/quiz_cubit.dart';
import 'package:ehliyetim/features/quiz/data/model/question_model.dart';
import 'package:ehliyetim/features/quiz/data/model/service/quiz_service.dart';
import 'package:ehliyetim/features/quiz/view/widgets/finish_test_dialog.dart';
import 'package:ehliyetim/features/quiz/view/widgets/icon_text_item.dart';
import 'package:ehliyetim/features/quiz/view/widgets/question_card.dart';
import 'package:ehliyetim/features/quiz/view/widgets/styles_container.dart';
import 'package:ehliyetim/product/consts/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (context) => QuizCubit(QuizService()),
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          return const _QuizView();
        },
      ),
    );
  }
}

class _QuizView extends StatefulWidget {
  const _QuizView({
    Key? key,
  }) : super(key: key);

  @override
  State<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<_QuizView> {
  late final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return Scaffold(
            appBar: _appBar(context, state),
            floatingActionButton: state.currentIndex == 0
                ? Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: context.dynamicHeight(.07),
                  )
                : Container(),
            body: Column(
              children: [_topView(), _body(state.questions)],
            ));
      },
    );
  }

  Expanded _body(List<QuestionModel> questions) {
    return Expanded(
        child: PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: (i) => context.read<QuizCubit>().updatePageIndex(i),
      itemCount: questions.length,
      itemBuilder: (_, i) => QuestionCard(
        questionModel: questions[i],
      ),
    ));
  }

  Widget _topView() {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return StyledContainer(
          context: context,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_timerView(), _correctWrongView(), _answeredQuestionsView(state)],
          ),
        );
      },
    );
  }

  IconTextRow _answeredQuestionsView(QuizState state) {
    return IconTextRow(
      icon: const Icon(Icons.contact_support),
      text: '${state.currentIndex + 1} / ${state.questions.length}',
    );
  }

  BlocSelector<QuizCubit, QuizState, int> _timerView() {
    return BlocSelector<QuizCubit, QuizState, int>(
      selector: (state) {
        return state.timerCount;
      },
      builder: (context, state) {
        return IconTextRow(
          icon: const Icon(Icons.timer_outlined),
          text: '$state',
        );
      },
    );
  }

  Widget _correctWrongView() {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return Row(
          children: [
            IconTextRow(
              icon: Icon(
                Icons.check_circle,
                color: context.appTheme.colorScheme.onTertiary,
              ),
              text: '${state.correctsCount}',
            ),
            const SizedBox(
              width: 5,
            ),
            IconTextRow(
              icon: Icon(
                Icons.cancel,
                color: context.appTheme.errorColor,
              ),
              text: '${state.wrongCounts}',
            )
          ],
        );
      },
    );
  }

  AppBar _appBar(BuildContext context, QuizState state) {
    return AppBar(
      leading: const Icon(Icons.arrow_back_ios),
      title: Column(
        children: [
          Icon(
            Icons.car_repair_outlined,
            color: context.appTheme.iconTheme.color,
          ),
          Text(
            LocaleKeys.myLicense,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<QuizCubit>().stopTimer();
            showDialog(
                context: context,
                builder: (_) => FinishDialog(
                      state: state,
                    ));
          },
          child: Text(
            LocaleKeys.finishTest,
            style: context.appTheme.textTheme.subtitle2?.copyWith(color: context.appTheme.iconTheme.color),
          ),
        )
      ],
      centerTitle: true,
    );
  }
}

import 'package:ehliyetim/features/quiz/cubit/quiz_cubit.dart';
import 'package:ehliyetim/features/quiz/data/model/service/quiz_service.dart';
import 'package:ehliyetim/features/quiz/view/widgets/icon_test_item.dart';
import 'package:ehliyetim/features/quiz/view/widgets/question_card.dart';
import 'package:ehliyetim/features/quiz/view/widgets/styles_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late ThemeData _themeContext;
  @override
  void didChangeDependencies() {
    _themeContext = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return Scaffold(
            appBar: _appBar(context),
            body: Column(
              children: [
                _topView(),
                Expanded(
                    child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) => context.read<QuizCubit>().updatePageIndex(i),
                  itemCount: state.questions.length,
                  itemBuilder: (_, i) => QuestionCard(
                    questionModel: state.questions[i],
                  ),
                ))
              ],
            ));
      },
    );
  }

  Widget _topView() {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return StyledContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocSelector<QuizCubit, QuizState, int>(
                selector: (state) {
                  return state.timer;
                },
                builder: (context, state) {
                  return IconTextRow(
                    icon: const Icon(Icons.timer_outlined),
                    text: '$state',
                  );
                },
              ),
              _correctWrong(),
              IconTextRow(
                icon: const Icon(Icons.contact_support),
                text: '${state.currentIndex + 1} / ${state.questions.length}',
              )
            ],
          ),
        );
      },
    );
  }

  Row _correctWrong() {
    return Row(
      children: const [
        IconTextRow(
          icon: Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          text: '0',
        ),
        SizedBox(
          width: 5,
        ),
        IconTextRow(
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
          ),
          text: '0',
        )
      ],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.arrow_back_ios),
      title: Column(
        children: [
          Icon(
            Icons.car_repair_outlined,
            color: _themeContext.iconTheme.color,
          ),
          Text(
            'Ehliyetim',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Testi Bitir',
            style: _themeContext.textTheme.subtitle2?.copyWith(color: _themeContext.iconTheme.color),
          ),
        )
      ],
      centerTitle: true,
    );
  }
}

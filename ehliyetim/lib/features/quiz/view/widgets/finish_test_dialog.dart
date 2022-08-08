import 'package:ehliyetim/features/quiz/cubit/quiz_cubit.dart';
import 'package:ehliyetim/product/consts/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FinishDialog extends StatelessWidget {
  final QuizState state;
  const FinishDialog({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: context.dynamicWidth(.7),
        height: context.dynamicHeight(.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_warningView(context), _explanationView(context), _pickOptionView(context)],
        ),
      ),
    );
  }

  Icon _warningView(BuildContext context) {
    return Icon(
      Icons.error,
      color: context.appTheme.errorColor,
      size: context.dynamicHeight(.15),
    );
  }

  Column _explanationView(BuildContext context) {
    return Column(
      children: [
        Text(
          LocaleKeys.beAware,
          style: context.appTheme.textTheme.titleLarge,
        ),
        Text(
          LocaleKeys.question,
          style: context.appTheme.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row _pickOptionView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_yesButton(context), context.emptySizedWidthBoxLow, _noButton(context)],
    );
  }

  Expanded _noButton(BuildContext context) {
    return Expanded(
      child: _optionButton(context, context.appTheme.errorColor, LocaleKeys.no, () {
        context.navigation.pop();
      }),
    );
  }

  Expanded _yesButton(BuildContext context) {
    return Expanded(
      child: _optionButton(context, context.appTheme.colorScheme.onTertiary, LocaleKeys.yes, () {
        showModalBottomSheet(context: context, builder: (context) => _ResultSheet(state: state));
      }),
    );
  }

  ElevatedButton _optionButton(BuildContext context, Color color, String name, void Function() onPressed) {
    return ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(primary: color), child: Text(name));
  }
}

class _ResultSheet extends StatelessWidget {
  const _ResultSheet({
    Key? key,
    required this.state,
  }) : super(key: key);

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: context.onlyTopPaddingNormal + context.horizontalPaddingNormal,
        decoration: BoxDecoration(
            color: context.appTheme.colorScheme.onPrimary, borderRadius: BorderRadius.all(context.normalRadius)),
        height: context.dynamicHeight(.6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  'Test Sonucu',
                  style: context.appTheme.textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => context.navigation.pop(),
                )
              ],
            ),
            context.emptySizedHeightBoxNormal,
            Row(
              children: [
                const Icon(Icons.map),
                context.emptySizedWidthBoxLow3x,
                Text(
                  LocaleKeys.testName,
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            context.emptySizedHeightBoxNormal,
            Expanded(
              child: Padding(
                padding: context.onlyTopPaddingNormal,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20,
                  children: _stats(context),
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> _stats(BuildContext context) {
    return [
      _StatItem(
        icon: Icons.timer_outlined,
        text: LocaleKeys.timePassed,
        value: state.timerCount,
        color: context.appTheme.iconTheme.color!,
      ),
      _StatItem(
        icon: Icons.question_answer,
        text: LocaleKeys.totalQuestionCount,
        value: state.questions.length,
        color: Colors.orange,
      ),
      _StatItem(
          icon: Icons.check_circle,
          text: LocaleKeys.corrects,
          value: state.correctsCount,
          color: context.colorScheme.onTertiary),
      _StatItem(
          icon: Icons.cancel, text: 'Yanlış Cevaplar', value: state.wrongCounts, color: context.appTheme.errorColor)
    ];
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.text,
    required this.value,
    required this.color,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final int value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(context.lowRadius)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            color: context.appTheme.scaffoldBackgroundColor,
          ),
          Text(
            text,
            style: context.appTheme.textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
          Text(
            '$value',
            style: context.appTheme.textTheme.bodySmall?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}

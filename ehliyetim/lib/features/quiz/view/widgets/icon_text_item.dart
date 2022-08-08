import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class IconTextRow extends StatelessWidget {
  final Icon icon;
  final String text;
  const IconTextRow({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, context.emptySizedHeightBoxLow3x, Text(text)],
    );
  }
}

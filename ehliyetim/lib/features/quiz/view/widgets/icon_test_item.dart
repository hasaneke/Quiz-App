import 'package:flutter/material.dart';

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
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Text(text)
      ],
    );
  }
}

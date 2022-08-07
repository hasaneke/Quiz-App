import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;
  const StyledContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(horizontal: 10) + const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: child);
  }
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StyledContainer extends Container {
  StyledContainer({
    required BuildContext context,
    required Widget child,
  }) : super(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            margin: context.horizontalPaddingNormal + context.onlyTopPaddingNormal,
            padding: context.paddingNormal,
            child: child);
}

import 'package:flutter/material.dart';
import 'index.dart';

class SafeAreaWrap extends StatefulWidget {
  final Widget child;
  const SafeAreaWrap(this.child, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SafeAreaWrap();
  }
}

class _SafeAreaWrap extends State<SafeAreaWrap> {
  final SafeAreaInsets insets = SafeAreaInsets();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: insets,
      builder: (context, EdgeInsets inset, Widget? child) {
        print('Inset1: $inset');
        return AnimatedPadding(
          padding: inset,
          duration: kThemeAnimationDuration,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

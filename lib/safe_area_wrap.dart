import 'package:flutter/material.dart';
import 'package:safe_insets/index.dart';
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
  final SafeAreaInsets _insets = SafeAreaInsets();

  @override
  void dispose() {
    _insets.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _insets,
      builder: (context, Inset inset, Widget? child) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return AnimatedPadding(
              padding: orientation == Orientation.portrait
                  ? EdgeInsets.only(
                      left: inset.left,
                      right: inset.right,
                      bottom: inset.bottom,
                      top: inset.top)
                  : EdgeInsets.only(
                      left: 0, right: 0, bottom: inset.bottom, top: inset.top),
              duration: kThemeAnimationDuration,
              child: child,
              curve: Curves.linear,
            );
          },
        );
      },
      child: widget.child,
    );
  }
}

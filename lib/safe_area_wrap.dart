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
  final SafeAreaInsets insets = SafeAreaInsets();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: insets,
      builder: (context, EdgeInsets inset, Widget? child) {
        print('Insets: $inset');
        return OrientationBuilder(builder: (context, orientation) {
          return AnimatedPadding(
            padding: orientation == Orientation.portrait
                ? inset
                : inset.copyWith(left: 0, right: 0),
            duration: const Duration(milliseconds: 100),
            child: child,
            curve: Curves.fastLinearToSlowEaseIn,
          );
        });
      },
      child: widget.child,
    );
  }
}

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

class _SafeAreaWrap extends State<SafeAreaWrap> with WidgetsBindingObserver {
  final SafeAreaInsets _insets = SafeAreaInsets();
  late Size _lastSize;
  double heightChange = 0;

  @override
  void initState() {
    super.initState();
    _lastSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _insets.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      Size newSize = WidgetsBinding.instance.window.physicalSize;
      heightChange = newSize.height - _lastSize.height;
      _lastSize = newSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _insets,
      builder: (context, Inset inset, Widget? child) {
        final double bottomInset = heightChange < 0 ? 0 : inset.bottom;
        // print('inset: $inset');
        // print('bottomInset: $bottomInset');
        return OrientationBuilder(builder: (context, orientation) {
          return AnimatedPadding(
            padding: orientation == Orientation.portrait
                ? EdgeInsets.only(
                    left: inset.left,
                    right: inset.right,
                    bottom: bottomInset,
                    top: inset.top)
                : EdgeInsets.only(
                    left: 0, right: 0, bottom: inset.bottom, top: inset.top),
            duration: kThemeAnimationDuration,
            child: child,
            curve: Curves.linear,
          );
        });
      },
      child: widget.child,
    );
  }
}

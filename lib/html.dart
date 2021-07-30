@JS()
library safe_area_insets;

import 'package:js/js.dart';
import 'interface.dart' as _interface;
import 'dart:ui' as ui;

typedef InsetCallbackHandler = void Function(Inset reult);

@JS('safeAreaInsets.onChange')
external void onChange(InsetCallbackHandler callback);
@JS('safeAreaInsets.offChange')
external void offChange(InsetCallbackHandler callback);
@JS('safeAreaInsets.left')
external num get left;
@JS('safeAreaInsets.top')
external num get top;
@JS('safeAreaInsets.right')
external num get right;
@JS('safeAreaInsets.bottom')
external num get bottom;

@JS()
@anonymous
class Inset {
  external num get left;
  external num get top;
  external num get right;
  external num get bottom;
}

class SafeAreaInsets extends _interface.SafeAreaInsets {
  late InsetCallbackHandler sub;

  SafeAreaInsets() {
    sub = allowInterop(_onChange);
    onChange(sub);
    final devicePixelRatio = ui.window.devicePixelRatio;
    value = value.copyWith(
      left: left.isNaN ? 0 : left.toDouble() / devicePixelRatio,
      top: top.isNaN ? 0 : top.toDouble() / devicePixelRatio,
      right: right.isNaN ? 0 : right.toDouble() / devicePixelRatio,
      bottom: bottom.isNaN ? 0 : bottom.toDouble() / devicePixelRatio,
    );
  }

  @override
  dispose() {
    offChange(sub);
    super.dispose();
  }

  void _onChange(Inset result) {
    final devicePixelRatio = ui.window.devicePixelRatio;
    value = value.copyWith(
      left: result.left.isNaN ? 0 : result.left.toDouble() / devicePixelRatio,
      top: result.top.isNaN ? 0 : result.top.toDouble() / devicePixelRatio,
      bottom:
          result.bottom.isNaN ? 0 : result.bottom.toDouble() / devicePixelRatio,
      right:
          result.right.isNaN ? 0 : result.right.toDouble() / devicePixelRatio,
    );
  }
}

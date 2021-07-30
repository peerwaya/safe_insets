@JS()
library safe_area_insets;

import 'package:js/js.dart';
import 'interface.dart' as _interface;
import 'dart:ui' as ui;
import 'dart:html' as html;

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

@JS('navigator.standalone')
external bool? get standAlone;

@JS('document.referrer')
external String? get referrer;

@JS()
@anonymous
class Inset {
  external num get left;
  external num get top;
  external num get right;
  external num get bottom;
}

void initializeViewPort() {
  final viewportMeta = html.MetaElement()
    ..setAttribute('flt-viewport', '')
    ..name = 'viewport'
    ..content =
        'width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no,viewport-fit=cover';
  html.document.head!.append(viewportMeta);
}

class SafeAreaInsets extends _interface.SafeAreaInsets {
  late InsetCallbackHandler sub;

  SafeAreaInsets() {
    sub = allowInterop(_onChange);
    onChange(sub);
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

  num get devicePixelRatio {
    return 1; //ui.window.devicePixelRatio;
  }

  bool get isInStandaloneMode =>
      (html.window.matchMedia('(display-mode: standalone)').matches) ||
      (standAlone ?? false) ||
      (referrer ?? '').contains('android-app://');

  void _onChange(Inset result) {
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

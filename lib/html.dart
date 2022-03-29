@JS()
library safe_area_insets;

import 'package:browser_adapter/io.dart';
import 'package:js/js.dart';
import 'interface.dart' as _interface;
import 'inset.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

typedef InsetCallbackHandler = void Function(InsetJs result);

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
class InsetJs {
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
    if (!isSafariBrowser()) {
      return;
    }
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
    if (isSafariBrowser()) {
      offChange(sub);
    }
    super.dispose();
  }

  num get devicePixelRatio {
    return 1; //ui.window.devicePixelRatio;
  }

  void _onChange(InsetJs result) {
    value = _toInset(result);
  }

  Inset _toInset(InsetJs inset) {
    return Inset(
      left: inset.left.isNaN ? 0 : inset.left.toDouble() / devicePixelRatio,
      top: inset.top.isNaN ? 0 : inset.top.toDouble() / devicePixelRatio,
      bottom:
          inset.bottom.isNaN ? 0 : inset.bottom.toDouble() / devicePixelRatio,
      right: inset.right.isNaN ? 0 : inset.right.toDouble() / devicePixelRatio,
    );
  }
}

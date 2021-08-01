import 'package:flutter/material.dart';
import 'inset.dart';

void initializeViewPort() {}

class SafeAreaInsets extends ValueNotifier<Inset> {
  SafeAreaInsets() : super(const Inset.zero());
}

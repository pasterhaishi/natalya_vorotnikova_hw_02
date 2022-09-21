import 'package:flutter/material.dart';
import 'widget_spisok.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const MySpisok(),
    // '/': (context) => const ImagePickerWidget(),
  }));
}

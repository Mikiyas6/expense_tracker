import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !const bool.fromEnvironment('dart.vm.product'),
      builder: (context) => MaterialApp(
        home: Expenses(),
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
      ),
    ),
  );
}

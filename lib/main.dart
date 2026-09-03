import 'package:flutter/material.dart';

import 'app.dart';

export 'app.dart' show DigitalProductApp;

class MyApp extends DigitalProductApp {
  const MyApp({super.key});
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

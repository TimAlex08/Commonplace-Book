// Flutter Imports
import 'package:flutter/material.dart';
import 'package:commonplace_book/app/app/app.dart';

// DI Imports
import 'package:commonplace_book/app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); 
  runApp(const App());
}
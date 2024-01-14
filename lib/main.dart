import 'package:flutter/material.dart';
import 'package:vivavox/config/theme/theme.dart';
import 'package:vivavox/presentation/pages/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivavox',
      theme: theme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: const Splashscreen(),
    );
  }
}

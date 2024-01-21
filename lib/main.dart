import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/config/theme/theme.dart';
import 'package:vivavox/presentation/pages/landingpage.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CardProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
    ],
    builder: (context, child) {
      return const MyApp();
    },
  ));
  // runApp(const MyApp());
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
      home: const LandingScreen(),
    );
  }
}

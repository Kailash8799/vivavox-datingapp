import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/config/theme/theme.dart';
import 'package:vivavox/presentation/pages/landingpage.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CardProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => StatusProvider(),
      ),
    ],
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

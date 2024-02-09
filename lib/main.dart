import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/config/theme/theme.dart';
import 'package:vivavox/presentation/pages/chatroom.dart';
import 'package:vivavox/presentation/pages/landingpage.dart';
import 'package:vivavox/presentation/pages/notfound.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/chatprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/presentation/providers/statusprovider.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';

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
      ChangeNotifierProvider(
        create: (context) => ChatProvider(),
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
      darkTheme: theme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      initialRoute: "/",
      routes: {
        "/": (context) => const LandingScreen(),
        "/chatroom": (context) => const ChatRoom(),
      },
      onGenerateRoute: (settings) {
        // print(settings.name);
        switch (settings.name) {
          case "chatroom":
            return AnimationTransition(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const NotFound();
              },
              opaque: false,
            );
          default:
            return AnimationTransition(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const NotFound();
              },
              opaque: false,
            );
        }
      },
      // home: const LandingScreen(),
    );
  }
}

import 'package:afet_yonetim/services/provider/user.dart';
import 'package:afet_yonetim/values.dart';
import 'package:afet_yonetim/views/screens/auth/login.dart';
import 'package:afet_yonetim/views/screens/auth/register.dart';
import 'package:afet_yonetim/views/screens/home.dart';
import 'package:afet_yonetim/views/screens/introduction.dart';
import 'package:afet_yonetim/views/screens/victim.dart';
import 'package:afet_yonetim/views/screens/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // TODO: Create this using flutterfire cli tool

import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(userProvider);
    return MaterialApp(
      title: 'Afet Yonetim',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      home: data.when(
        data: (user) {
          if (user == null) {
            return const IntroductionScreen();
          } else {
            currentUser = user;
            return const HomeScreen();
          }
        },
        error: (error, s) => const IntroductionScreen(),
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        switch (settings.name) {
          case '/introduction':
            page = const IntroductionScreen();
            break;
          case '/login':
            page = const LoginScreen();
            break;
          case '/register':
            page = const RegisterScreen();
            break;
          case '/home':
            page = const HomeScreen();
            break;
          case '/victim':
            page = const VictimScreen();
            break;
          case '/volunteer':
            page = const VolunteerScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => page,
        );
      },
    );
  }
}

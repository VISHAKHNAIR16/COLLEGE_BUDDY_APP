import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:microit_app/screen/onboardingscreen.dart';
import 'package:microit_app/screen/home_screen.dart';
import 'package:microit_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 96, 66));

var kdarkcolorScehme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 41, 96));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "On Boarding Screen",
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const Onboardingscreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

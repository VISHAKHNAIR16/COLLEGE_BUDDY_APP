import 'package:flutter/material.dart';
import 'package:microit_app/appbar/curveappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  OnboardingscreenState createState() => OnboardingscreenState();
}

class OnboardingscreenState extends State<Onboardingscreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void onSelectedNextScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: ClipPath(
          clipper: Curveappbar(),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/design.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/images/study.png",
              height: 300,
              width: 450,
            ),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    "Welcome to VSync!",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  width: 22,
                ),
                Expanded(
                  child: Text(
                    "Your College Companion",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                onSelectedNextScreen(context);
              },
              label: const Text("Get Started"),
              icon: const Icon(Icons.arrow_forward_outlined),
              iconAlignment: IconAlignment.end,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 26, 96, 66),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:microit_app/appbar/curveappbar.dart';
import 'package:microit_app/screen/gpa_or_cgpa.dart';
import 'package:microit_app/screen/image_upload_screen.dart';
import 'package:microit_app/screen/login_screen.dart';
import 'package:microit_app/screen/aboutus_screen.dart';
import 'package:microit_app/screen/faculty_screen.dart';
import 'package:microit_app/screen/gpa_calculator.dart';
import 'package:microit_app/screen/wifi_auth_screen.dart';
import 'package:microit_app/widget/home_screen_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;
  String userName = '';
  @override
  void initState() {
    super.initState();
    _checkAuth();
    _fetchUserName();
  }

  Future<void> _checkAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {}
    });
  }

  Future<void> _fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          setState(() {
            userName = userData?['firstName'] ?? '';
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: ClipPath(
          clipper: Curveappbar(),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                const AboutusScreen();
              },
              icon: Image.asset(
                "assets/images/menu.png",
                color: Colors.black54,
              ),
            ),
            leadingWidth: 75.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/design.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const WifiAuthScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.wifi_password_rounded,
                      color: Colors.black54,
                      size: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Home,",
              style: TextStyle(fontSize: 30, color: Colors.grey[700]),
            ),
            Text(
              userName.isNotEmpty
                  ? userName
                  : "VITIAN", //vitian only if name not available
              style: TextStyle(fontSize: 30, color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.25),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const FacultyScreen(),
                        ),
                      );
                    },
                    child: const HomeScreenBox(
                        name: "Faculty Info",
                        iconPath: "assets/icons/student.png"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const GpaCalculatorScreen(),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const GpaOrCgpa(),
                        ),
                      );
                    },
                    child: const HomeScreenBox(
                        name: "Calculator",
                        iconPath: "assets/icons/calculator.png"),
                  ),
                  const HomeScreenBox(
                      name: "My Curriculum",
                      iconPath: "assets/icons/scroll.png"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const ImageUploadScreen(),
                        ),
                      );
                    },
                    child: const HomeScreenBox(
                        name: "TimeTable",
                        iconPath: "assets/icons/Time Table.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

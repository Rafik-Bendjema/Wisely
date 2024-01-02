import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/splash/presentation/Splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //opening the database
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    checkFirstTimeUser();
    super.initState();
  }

  Future<void> checkFirstTimeUser() async {
    bool isFirstTimeUser = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    setState(() {
      isFirstTimeUser = isFirstTime;
    });

    if (isFirstTime) {
      // Perform actions for the first time user
      // For example, show onboarding screens, tutorials, etc.

      // Set isFirstTime to false to indicate that the user has launched the app before
      prefs.setBool('isFirstTime', false);
    }
    print("this is the first time ? $isFirstTime");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: const Splash());
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/database/DataBase.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/categorise/domain/riverpod/CategoryProvider.dart';
import 'package:wisely/features/income/domain/riverpod/IncomProvider.dart';
import 'package:wisely/features/introduction/presentation/pages/Introduction.dart';
import '../../../features/expenses/domain/riverpod/ExpensesProvider.dart';
import 'clipper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity = 0;
  @override
  void initState() {
    checkFirstTimeUser();
    super.initState();
    fading();
  }

  bool firstTime = true;

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
    firstTime = isFirstTime;
    print("this is the first time ? $isFirstTime");
  }

  void fading() async {
    await DatabaseHelper.opendatabase();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        _opacity = 1;
      });
      Future.delayed(const Duration(seconds: 4)).then((value) => {
            if (firstTime)
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Introduction()))
              }
            else
              {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Introduction()))
              }
          });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFE3FFFA)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(builder: (context, ref, widget) {
                if (_opacity == 1) {
                  //open database
                  //fetch data
                  ref.read(expensesProvider2.notifier).reloadData();
                  ref.read(categoryProvider.notifier).reloadData();
                  ref.read(sourceProvider.notifier).reloadData();
                  ref.read(incomeProvider.notifier).reloadData();
                  ref.read(expensesSum.notifier).reloadData();
                }

                return const SizedBox(
                  height: 0,
                );
              }),
              AnimatedOpacity(
                duration: const Duration(seconds: 3),
                opacity: _opacity,
                child: ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0XFFA7E8BD)),
                    child: CustomPaint(
                      size: Size(
                          200,
                          (200 * 1)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              DefaultTextStyle(
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 55, 55, 55)),
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      "wisely",
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wisely/core/home/presentation/home_view.dart';
import 'package:wisely/features/introduction/presentation/widgets/FeaturesTwo.dart';
import 'package:wisely/features/introduction/presentation/widgets/featuresPage.dart';
import 'package:wisely/features/introduction/presentation/widgets/welcome.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      done: const Text("done"),
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      },
      showDoneButton: true,
      showNextButton: true,
      next: const Text("next"),
      key: _introKey,
      pages: [
        PageViewModel(
            title: "", bodyWidget: const WelcomePage(), useScrollView: false),
        PageViewModel(
            title: "", bodyWidget: const FeaturesPage(), useScrollView: false),
        PageViewModel(
            title: "", bodyWidget: const FeaturesTwo(), useScrollView: false)
      ],
    );
  }
}

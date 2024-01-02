import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wisely/features/income/presentation/widgets/AddIncome.dart';
import 'package:wisely/features/income/presentation/widgets/IncomeList.dart';
import '../../../../core/resources/colors.dart';

class IncomeView extends StatefulWidget {
  const IncomeView({super.key});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    print("start listening");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    print(_lastWords);
  }

  void _stopListening() async {
    print("finish listening");
    await _speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: AddIncome(),
                  ));
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: background_color),
              child: const SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Incomes",
                        style: TextStyle(
                            fontSize: 36, color: Color.fromARGB(189, 0, 0, 0)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(child: IncomeList())
                  ],
                ),
              )),
          Positioned(
              bottom: 0,
              child: ElevatedButton(
                onPressed: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                child: Icon(
                    _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
              )),
        ],
      ),
    );
  }
}

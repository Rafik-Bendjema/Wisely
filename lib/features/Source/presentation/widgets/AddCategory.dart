import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';

class AddSource extends StatefulWidget {
  const AddSource({super.key});

  @override
  State<AddSource> createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  SourceDb sourceDb = SourceDbImpl();

  Color _selected_color = Colors.transparent;

  late String title;
  late int amount;

  final _globalKey = GlobalKey<FormState>();

  submit(WidgetRef ref) async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      Source source =
          Source(title: title, amount: amount, color: _selected_color.value);

      bool result = await sourceDb.addSourceDb(ref, source);

      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                      child:
                          result ? const Text("succes") : const Text("failed")),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: _globalKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            onSaved: (value) {
              title = value!;
            },
            validator: (t) {
              if (t!.isEmpty || t == "") {
                return "this field can't be empty !";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "title",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            onSaved: (value) {
              amount = int.parse(value!);
            },
            validator: (t) {
              if (t!.isEmpty || t == "") {
                return "this field can't be empty !";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "amount",
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Text("selected color is "),
              Icon(
                Icons.square,
                color: _selected_color,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: ColorPicker(onColorChanged: (c) {
                              print("selected color is ${c.value}");
                              setState(() {
                                _selected_color = c;
                              });
                            }),
                          ));
                },
                child: const Text("PICK COLOR"),
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer(
              builder: (context, ref, widget) => ElevatedButton(
                  onPressed: () {
                    submit(ref);
                    Navigator.pop(context);
                  },
                  child: const Text('Add')))
        ]),
      ),
    );
  }
}

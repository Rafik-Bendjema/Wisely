import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';

class AddSource extends StatefulWidget {
  Source? destination;
  AddSource({super.key, this.destination});

  @override
  State<AddSource> createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  Source? _destination;

  @override
  void initState() {
    _destination = widget.destination;
    if (_destination != null) {
      title_cntrl = TextEditingController(text: _destination!.title);
      amount_cntrl =
          TextEditingController(text: _destination!.amount.toString());
    }
    super.initState();
  }

  //controllers
  TextEditingController title_cntrl = TextEditingController();

  TextEditingController amount_cntrl = TextEditingController();

  SourceDb sourceDb = SourceDbImpl();

  late String title;
  late int amount;

  final _globalKey = GlobalKey<FormState>();

  submit(WidgetRef ref) async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      bool result;
      Source source = Source(title: title, amount: amount);
      if (_destination == null) {
        result = await sourceDb.addSourceDb(ref, source);
      } else {
        source.id = _destination!.id;
        result = await sourceDb.editSource(ref, source);
      }

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
            controller: title_cntrl,
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
            controller: amount_cntrl,
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
          const SizedBox(
            height: 30,
          ),
          Consumer(
              builder: (context, ref, widget) => ElevatedButton(
                  onPressed: () {
                    submit(ref);
                    Navigator.pop(context);
                  },
                  child: _destination == null
                      ? const Text('Add')
                      : const Text("Edit")))
        ]),
      ),
    );
  }
}

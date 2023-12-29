import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final CategoryDb _categoryDb = CategoryDb_impl();
  late String title;
  Icon? _pickedIcon;

  final _globalKey = GlobalKey<FormState>();

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _pickedIcon = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  void submit(WidgetRef ref) async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();

      Category cat = Category(title: title, icon: _pickedIcon?.icon!.codePoint);
      bool status = await _categoryDb.addCategoryDb(ref, cat);
      if (status) {
        print("error in adding a state ");
        return;
      }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (_pickedIcon != null)
                  ? Row(
                      children: [const Text("picked icon is   "), _pickedIcon!],
                    )
                  : const Text("icon not selected"),
              ElevatedButton(
                  onPressed: _pickIcon, child: const Text("pick icon"))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer(
              builder: (context, ref, widget) => ElevatedButton(
                  onPressed: () {
                    submit(ref);
                  },
                  child: const Text('Add')))
        ]),
      ),
    );
  }
}

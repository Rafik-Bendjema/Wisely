import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/splash/presentation/Splash_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'features/expenses/domain/entites/Expanses.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(ExpansesAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(SourceAdapter());

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initbox() async {}

  void dispose() {
    print("the app is closing");

    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}

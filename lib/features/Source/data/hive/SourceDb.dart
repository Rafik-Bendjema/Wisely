import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';

import '../../../../core/database/DataBase.dart';
import '../../domain/entities/Source.dart';

abstract class SourceDb {
  Future<bool> addSourceDb(WidgetRef ref, Source source);
  Future<bool> deleteSourceDb(WidgetRef ref, Source source);
  Future<bool> editSource(WidgetRef ref, Source newSource);
  Future<List<Source>> getSources();
  Future<Source?> getSource(String? id);
  Future<Source?> checkMain();
}

class SourceDbImpl implements SourceDb {
  @override
  Future<bool> addSourceDb(WidgetRef ref, Source source) async {
    try {
      await DatabaseHelper.database!.insert('source', source.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      ref.read(sourceProvider.notifier).reloadData();
      //to do the income provider
      return true;
    } catch (e) {
      print("Error in adding a source. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> deleteSourceDb(WidgetRef ref, Source source) async {
    try {
      if (source.id == "0") {
        return false;
      }
      await DatabaseHelper.database!
          .delete('source', where: "id = ?", whereArgs: [source.id]);
      // Reload data for any provider that needs to react to source changes
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("Error in deleting source. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> editSource(WidgetRef ref, Source newSource) async {
    try {
      await DatabaseHelper.database!.update('source', newSource.toMap(),
          where: "id = ?", whereArgs: [newSource.id]);
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Source>> getSources() async {
    List<Source> sourcesList = [];
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> sourcesMap =
        await DatabaseHelper.database!.query('source');

    print("This is the sources $sourcesMap");
    // Generate a list from the map
    for (var element in sourcesMap) {
      Source curr = Source.withId(
        id: element['id'] as String,
        title: element['title'] as String,
        amount: element['amount'] as int,
      );
      sourcesList.add(curr);
    }
    return sourcesList;
  }

/*  @override
  Future<Source?> getSource(String? name, WidgetRef ref) async {
    if (name == null) {
      return null;
    }
    List<Source> sources = ref.read(sourceProvider);
    for (var source in sources) {
      if (source.title.toLowerCase() == name.toLowerCase()) {
        return source;
      }
    }
    Source source = Source(amount: 0, title: name);
    await addSourceDb(ref, source);
    return null;
  }
*/
  @override
  Future<Source?> checkMain() async {
    List<Map<String, dynamic>> mainSource =
        await DatabaseHelper.database!.query('mainSource');
    int? amount;
    if (mainSource.isNotEmpty) {
      if (mainSource[0]['amount'] == null) {
        print("the main source is null");
        return null;
      }
      amount = int.parse(mainSource[0]['amount'].toString());

      print("this is the main source amount $amount");

      Source s = Source(title: "main", amount: amount);
      return s;
    }
    return null;
  }

  @override
  Future<Source?> getSource(String? id) async {
    if (id == null) {
      return null;
    }
    List<Map<String, dynamic>> result = await DatabaseHelper.database!
        .query('source', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Source.fromMap(result[0]);
    }
    return null;
  }
}

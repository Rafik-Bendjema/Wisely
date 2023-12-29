import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';

import '../../../../core/database/DataBase.dart';
import '../../domain/entities/Source.dart';

abstract class SourceDb {
  Future<bool> addSourceDb(WidgetRef ref, Source source);
  Future<bool> deleteSourceDb(WidgetRef ref, Source source);
  Future<bool> editSource(WidgetRef ref, Source newSource, Source oldSource);
  Future<List<Source>> getSources();
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
      await DatabaseHelper.database!
          .delete('source', where: "id = ?", whereArgs: [source.id]);
      // Reload data for any provider that needs to react to source changes
      // ref.read(sourcesProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("Error in deleting source. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> editSource(WidgetRef ref, Source newSource, Source oldSource) {
    // TODO: Implement editSource
    throw UnimplementedError();
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
        color: element['color'] as int,
      );
      sourcesList.add(curr);
    }
    return sourcesList;
  }
}

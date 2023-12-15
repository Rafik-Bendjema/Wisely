import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';

abstract class SourceDb {
  Future<Box<Source>?> openBox();
  Future<bool> deleteSource(WidgetRef ref, Source s);
  Future<bool> addSource(WidgetRef ref, Source s);
  Future<bool> editSource(WidgetRef ref, Source newS, Source oldS);
  Future<List<Source>> getSources();
}

class SourceDbImpl implements SourceDb {
  @override
  Future<Box<Source>?> openBox() async {
    Box<Source>? b = await Hive.openBox('Sources');
    return b;
  }

  @override
  Future<bool> addSource(WidgetRef ref, Source s) async {
    try {
      Box<Source>? b = await openBox();
      if (b == null) {
        print("error in opening source box");
        return false;
      }
      await b.put(s.id, s);
      //provider shit
      ref.read(sourceProvider.notifier).reloadData();
    } catch (e) {
      print("error in adding a a source object ");
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteSource(WidgetRef ref, Source s) async {
    try {
      Box<Source>? b = await openBox();
      if (b == null) {
        print("error in opening source box");
        return false;
      }
      await b.delete(s.id);
    } catch (e) {
      print("error in deleting a source");
      return false;
    }
    return true;
  }

  @override
  Future<bool> editSource(WidgetRef ref, Source newS, Source oldS) {
    // TODO: implement editSource
    throw UnimplementedError();
  }

  @override
  Future<List<Source>> getSources() async {
    try {
      Box<Source>? b = await openBox();
      if (b == null) {
        print("error in opening source box");
        return [];
      }
      return b.values.toList();
    } catch (e) {
      print("error in fetching sources");
      return [];
    }
  }
}

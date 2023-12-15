import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';

final sourceProvider =
    StateNotifierProvider<SourceNotifier, List<Source>>((ref) {
  return SourceNotifier();
});

class SourceNotifier extends StateNotifier<List<Source>> {
  SourceDb sourceDb = SourceDbImpl();
  SourceNotifier() : super([]);

  void reloadData() async {
    state = await sourceDb.getSources();
  }
}

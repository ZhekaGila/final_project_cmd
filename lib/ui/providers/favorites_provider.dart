import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

import '../../data/services/local/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final favoritesProvider = FutureProvider<List<Favorite>>((ref) async {
  final db = ref.read(databaseProvider);

  return db.getFavorites();
});

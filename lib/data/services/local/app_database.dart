import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Favorites extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  RealColumn get price => real()();

  TextColumn get image => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Favorites])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Favorite>> getFavorites() {
    return select(favorites).get();
  }

  Future<void> insertFavorite(FavoritesCompanion favorite) {
    return into(favorites).insert(favorite, mode: InsertMode.insertOrIgnore);
  }

  Future<void> deleteFavorite(int id) {
    return (delete(favorites)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(p.join(dbFolder.path, 'app.sqlite'));

    return NativeDatabase(file);
  });
}

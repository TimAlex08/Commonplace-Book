// External Imports
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Tables
import 'tables/page_table.dart';
import 'tables/folder_table.dart';
import 'tables/notebook_structure_table.dart';
import 'tables/notebook_table.dart';

part 'app_database.g.dart';



@DriftDatabase(tables: [NotebookItems, NotebookStructureItems, FolderItems, PageItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 2;
  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from == 1) {
        // Simplemente crea la nueva tabla con todo correctamente
        await customStatement('''
          CREATE TABLE notebook_structure_items (
            id TEXT PRIMARY KEY,
            notebook_id TEXT NOT NULL REFERENCES notebook_items(id) ON DELETE CASCADE,
            parent_id TEXT REFERENCES notebook_content(id) ON DELETE CASCADE,
            position INTEGER NOT NULL,
            depth INTEGER NOT NULL,
            folder_id TEXT REFERENCES notebook_content(id) ON DELETE CASCADE,
            page_id TEXT REFERENCES notebook_content(id) ON DELETE CASCADE,
            type TEXT NOT NULL CHECK (type IN ('folder', 'page')),
            CHECK (
              (type = 'folder' AND folder_id IS NOT NULL AND page_id IS NULL)
              OR
              (type = 'page' AND page_id IS NOT NULL AND folder_id IS NULL)
            )
          );
        ''');
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(name: 'commonplace_book.db');
  });
}
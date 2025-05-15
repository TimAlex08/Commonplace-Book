// External Imports
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Tables
import 'tables/page_table.dart';
import 'tables/folder_table.dart';
import 'tables/notebook_content_table.dart';
import 'tables/notebook_table.dart';

part 'app_database.g.dart';



@DriftDatabase(tables: [NotebookItems, NotebookContentTable, Folders, Page])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(name: 'commonplace_book.db');
  });
}
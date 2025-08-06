


import 'package:drift/drift.dart';

class FolderItems extends Table {
  // ID de la tabla
  TextColumn get id => text()();
  
  // Nombre de la carpeta
  TextColumn get title => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
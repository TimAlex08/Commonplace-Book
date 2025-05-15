import 'package:drift/drift.dart';



class Page extends Table {
  // ID  de la tabla
  TextColumn get id => text()();
  
  // Nombre de la página
  TextColumn get title => text()();
  
  // Fecha de creación y actualización
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  
  @override
  Set<Column<Object>>? get primaryKey => {id};  
}
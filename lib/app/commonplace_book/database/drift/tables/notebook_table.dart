// Externar Imports
import 'package:drift/drift.dart';



class NotebookItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get color => text()();
  TextColumn get coverImagePath => text()();
  TextColumn get backCoverImagePath => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isLocked => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column<Object>> get primaryKey => {id};
}
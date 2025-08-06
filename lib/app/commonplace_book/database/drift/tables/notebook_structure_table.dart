// External Imports
import 'package:drift/drift.dart';



class NotebookStructureItems extends Table {
  // ID de la tabla
  TextColumn get id => text()();
  
  // Claves foráneas, `NotebookId` referencia la tabla `notebook_items` y `parentId` referencia la tabla `notebook_content`
  TextColumn get notebookId => 
    text().customConstraint('REFERENCES notebook_items(id) ON DELETE CASCADE')();
  TextColumn get parentId => 
    text().nullable().customConstraint('REFERENCES notebook_content(id) ON DELETE CASCADE')();
  
  TextColumn get type => text().customConstraint("CHECK (type IN ('folder', 'page'))")();
  
  // Claves foráneas, `FolderId` referencia a la tabla `FolderItems` y `PageId` referencia a la tabla `PageItems`
  // Solo puede existir un `FolderId` o un `PageId` a la vez, por lo que se establece una restricción de chequeo
  TextColumn get folderId => 
    text().nullable().customConstraint('REFERENCES notebook_content(id) ON DELETE CASCADE')();  
  TextColumn get pageId => 
    text().nullable().customConstraint('REFERENCES notebook_content(id) ON DELETE CASCADE')();
  
  // Columnas de posición y profundidad
  IntColumn get position => integer()();
  IntColumn get depth => integer()();
  
  @override
  Set<Column<Object>>? get primaryKey => {id};
  
  // Establece una restricción de chequeo para asegurar que solo uno de `FolderId` o `PageId` sea no nulo.
  @override
  List<String> get customConstraints => [
    '''
    CHECK (
      (type = 'folder' AND folder_Id IS NOT NULL AND page_Id IS NULL) OR
      (type = 'page' AND page_Id IS NOT NULL AND folder_Id IS NULL)
    )
    '''
  ];
}
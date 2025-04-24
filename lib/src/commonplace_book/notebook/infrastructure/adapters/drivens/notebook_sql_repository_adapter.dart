// Entities
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:commonplace_book/app/dependency_injection.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

// DataBase Helper
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';

// Ports
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



class NotebookDriftRepositoryAdapter implements ForPersitingNotebooksPort{
  const NotebookDriftRepositoryAdapter(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  NotebookPersistenceCommands get commands => NotebookSQLCommands(_dbHelper);

  @override
  NotebookPersistenceObservers get observers => throw UnimplementedError();

  @override
  NotebookPersistenceQueries get queries => throw UnimplementedError();
}


/// NotebookSQLCommands: Implementación de los comandos para la persistencia de `Notebook` en SQL.
class NotebookSQLCommands implements NotebookPersistenceCommands {
  const NotebookSQLCommands(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  Future<int> createNotebook(Notebook notebook) async {
    final dto = NotebookDTO.fromDomain(notebook);
    final companion = dto.toCompanion();
    
    int result = await _dbHelper.into(_dbHelper.notebookItems).insert(companion);
    
    return result;
  }
  
  @override
  Future<int> updateNotebook(Notebook notebook) async{
    final dto = NotebookDTO.fromDomain(notebook);
    final companion = dto.toCompanion();
    
    int result = await (_dbHelper.update(_dbHelper.notebookItems)
      ..where((tbl) => tbl.id.equals(dto.id))
    ).write(companion);
    
    return result;
  }
  
  @override
  Future<int> hardDeleteNotebook(String id) async {
    int result = await (_dbHelper.delete(_dbHelper.notebookItems)
      ..where((tbl) => tbl.id.equals(id))
    ).go();
    
    return result;
  }
}



class NotebookSQLQueries implements NotebookPersistenceQueries {
  NotebookSQLQueries();
  final AppDatabase db = getIt<AppDatabase>();
  
  @override
  Future<List<NotebookDTO>> getAllNotebooks() async{
    throw UnimplementedError();
  }
  
  @override
  Future<NotebookDTO?> getNotebookById(String id) async{
    throw UnimplementedError();
  }
}

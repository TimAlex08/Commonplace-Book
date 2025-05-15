// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/native.dart';

// Failure / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_infrastructure_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/sqlite_failure_mapper.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



/// NotebookDriftRepositoryAdapter: Adaptador para la persistencia de `Notebook` en DRIFT (Basado en Sqlite).
class NotebookDriftRepositoryAdapter implements ForPersitingNotebooksPort{
  const NotebookDriftRepositoryAdapter(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  NotebookPersistenceCommands get commands => NotebookSQLCommands(_dbHelper);

  @override
  NotebookPersistenceObservers get observers => NotebookSQLObservers(_dbHelper);

  @override
  NotebookPersistenceQueries get queries => NotebookSQLQueries(_dbHelper);
}



/// NotebookSQLCommands: Implementación de los comandos para la persistencia de `Notebook` en SQL.
class NotebookSQLCommands implements NotebookPersistenceCommands {
  const NotebookSQLCommands(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  /// Crea un nuevo `Notebook` en la base de datos.
  Future<Result<int, Failure>> createNotebook(Notebook notebook) async {
    try {
      final NotebookDTO dto = NotebookDomainMapper.fromDomain(notebook);
      final NotebookItemsCompanion notebookCompanion = NotebookDriftMapper.toCompanion(dto);
      
      final int result = await _dbHelper.into(_dbHelper.notebookItems).insert(notebookCompanion);
      
      return Result.success(result);
      
    } on SqliteException catch (e) {
        return Result.failure(SqliteFailureMapper.map(e, NotebookInsertFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}'
        )));
        
    } catch (e) {
        return Result.failure(NotebookInsertFailure(details: 'UNEXPECTED ERROR ${e.toString()}'));
    }
  }
  
  @override
  /// Actualiza un `Notebook` existente en la base de datos.
  Future<Result<int, Failure>> updateNotebook(Notebook notebook) async {
    try {
      final NotebookDTO dto = NotebookDomainMapper.fromDomain(notebook);
      final NotebookItemsCompanion notebookCompanion = NotebookDriftMapper.toCompanion(dto);
    
      final int result = await (_dbHelper.update(_dbHelper.notebookItems)
        ..where((tbl) => tbl.id.equals(dto.id!))
      ).write(notebookCompanion);
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(NotebookUpdateFailure(details: 'Notebook not found to update.'));
          
    } on SqliteException catch (e) {
        return Result.failure(SqliteFailureMapper.map(e, NotebookUpdateFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}'
        )));
        
    } catch (e) {
        return Result.failure(NotebookUpdateFailure(details: 'UNEXPECTED ERROR ${e.toString()}'));
    }
  }
  
  @override
  /// Elimina un `Notebook` de la base de datos.
  Future<Result<int, Failure>> hardDeleteNotebook(String id) async {
    try {
      final int result = await (_dbHelper.delete(_dbHelper.notebookItems)
        ..where((tbl) => tbl.id.equals(id))
      ).go();
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(NotebookDeleteFailure(details: 'Notebook not found to update.'));
          
    } on SqliteException catch (e) {
        return Result.failure(SqliteFailureMapper.map(e, NotebookDeleteFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}'
        )));
        
    } catch (e) {
        return Result.failure(NotebookDeleteFailure(details: 'UNEXPECTED ERROR ${e.toString()}'));
    }
  }
}



/// NotebookSQLCommands: Implementación de las consultas para la persistencia de `Notebook` en SQL.
class NotebookSQLQueries implements NotebookPersistenceQueries {
  const NotebookSQLQueries(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  /// Obtiene todos los `Notebook` de la base de datos. Puede devolver una lista vacía si no hay `Notebook`.
  Future<Result<List<NotebookDTO>?, Failure>> getAllNotebooks() async {
    try {
      final query = _dbHelper.select(_dbHelper.notebookItems);
      final List<NotebookItem> records = await query.get();
      
      final List<NotebookDTO> result = records.map((records) => NotebookDriftMapper.fromData(records)).toList();
      return Result.success(result);
      
    } on SqliteException catch (e) {
        return Result.failure(SqliteFailureMapper.map(e, NotebookReadFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}'
        )));
        
    } catch (e) {
        return Result.failure(NotebookReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}'));
    }
  }
  
  @override
  /// Obtiene un `Notebook` por su ID de la base de datos. Si no se encuentra, devuelve un error.
  Future<Result<NotebookDTO, Failure>> getNotebookById(String id) async{
    try {
      final query = _dbHelper.select(_dbHelper.notebookItems)
        ..where((tbl) => tbl.id.equals(id));
    
      final NotebookItem? record = await query.getSingleOrNull();
      
      return record != null 
          ? Result.success(NotebookDriftMapper.fromData(record))
          : Result.failure(NotebookReadFailure(details: 'Notebook not found.'));
          
    } on SqliteException catch (e) {
        return Result.failure(SqliteFailureMapper.map(e, NotebookReadFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}'
        )));
        
    } catch (e) {
        return Result.failure(NotebookReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}'));
    }
  }
}



/// NotebookSQLCommands: Implementación de los observadores para la persistencia de `Notebook` en SQL.
class NotebookSQLObservers implements NotebookPersistenceObservers {
  const NotebookSQLObservers(this._dbHelper);
  final AppDatabase _dbHelper;
  
  @override
  /// Observa todos los `Notebook` en la base de datos. Devuelve un `Stream` de listas de `NotebookDTO`.
  Stream<List<NotebookDTO>> watchAllNotebooks() {
    final Stream<List<NotebookItem>> stream = _dbHelper.select(_dbHelper.notebookItems).watch();
    
    return stream.map(
      (rows) => rows.map(NotebookDriftMapper.fromData).toList()
    );
  }
  
  @override
  /// Observa un `Notebook` por su ID en la base de datos. Devuelve un `Stream` de `NotebookDTO`.
  Stream<NotebookDTO> watchNotebookById(String id) {
    final query = _dbHelper.select(_dbHelper.notebookItems)
      ..where((tbl) => tbl.id.equals(id));
      
    final Stream<NotebookItem> stream = query.watchSingle();
    return stream.map(NotebookDriftMapper.fromData);
  }
}
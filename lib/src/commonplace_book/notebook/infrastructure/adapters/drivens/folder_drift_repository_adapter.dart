// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/native.dart';

// Failure / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_infrastructure_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_sqlite_failure_mapper.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



/// FolderDriftRepositoryAdapter: Adaptador para la persistencia de `Folder` en Drift (Basado en Sqlite).
class FolderDriftRepositoryAdapter implements ForPersistingFoldersPort {
  const FolderDriftRepositoryAdapter(this._db);
  final AppDatabase _db;
  
  @override
  FolderPersistenceCommands get commands => _FolderDriftCommands(_db);
  
  @override
  FolderPersistenceQueries get queries => _FolderDriftQueries(_db);
  
  @override
  FolderPersistenceObservers get observers => _FolderDriftObservers(_db);
}



/// FolderDriftCommands: Implementación de los comandos para la persistencia de `Folder` en Drift.
class _FolderDriftCommands implements FolderPersistenceCommands {
  const _FolderDriftCommands(this._db);
  final AppDatabase _db;
  
  @override
  /// CreateFolder: Crea un nuevo `Folder` en la base de datos.
  Future<Result<int, Failure>> createFolder(Folder folder) async {
    try {
      final FolderDTO dto = FolderDomainMapper.fromDomain(folder);
      final FolderItemsCompanion folderCompanion = FolderDriftMapper.toCompanion(dto);
      
      final int result = await _db.into(_db.folderItems).insert(folderCompanion);
      return Result.success(result);
      
    } on SqliteException catch (e) {
      return Result.failure(FolderSqliteFailureMapper.map(e, FolderInsertFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
      return Result.failure(FolderInsertFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  /// UpdateFolder: Actualiza un `Folder` existente en la base de datos.
  Future<Result<int, Failure>> updateFolder(Folder folder) async {
    try {
      final FolderDTO dto = FolderDomainMapper.fromDomain(folder);
      final FolderItemsCompanion folderCompanion = FolderDriftMapper.toCompanion(dto);
    
      final int result = await (_db.update(_db.folderItems)
        ..where((tbl) => tbl.id.equals(dto.id!))
      ).write(folderCompanion);
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(FolderUpdateFailure(details: 'Folder not found to update.'));
          
    } on SqliteException catch (e) {
        return Result.failure(FolderSqliteFailureMapper.map(e, FolderUpdateFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
        
    } catch (e) {
        return Result.failure(FolderUpdateFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<int, Failure>> hardDeleteFolder(String id) async {
    try {
      final int result = await (_db.delete(_db.folderItems)
        ..where((tbl) => tbl.id.equals(id))
      ).go();
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(FolderDeleteFailure(details: 'Folder not found to delete.'));
          
    } on SqliteException catch (e) {
        return Result.failure(FolderSqliteFailureMapper.map(e, FolderDeleteFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
        
    } catch (e) {
        return Result.failure(FolderDeleteFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
}



/// FolderDriftQueries: Implementación de las consultas para la persistencia de `Folder` en Drift.
class _FolderDriftQueries implements FolderPersistenceQueries {
  const _FolderDriftQueries(this._db);
  final AppDatabase _db;
  
  @override
  /// GetAllFolders: Obtiene todos los `Folder` de la base de datos. Puede devolver una lista vacía si no hay `Folder`.
  Future<Result<List<FolderDTO>?, Failure>> getAllFolders() async {
    try {
      final query = _db.select(_db.folderItems);
      final List<FolderItem> records = await query.get();
      
      final List<FolderDTO> result = records.map((records) => FolderDriftMapper.fromData(records)).toList();
      return Result.success(result);
      
    } on SqliteException catch (e) {
        return Result.failure(FolderSqliteFailureMapper.map(e, FolderReadFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
        
    } catch (e) {
        return Result.failure(FolderReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  /// GetFolderById: Obtiene un `Folder` por su ID.
  Future<Result<FolderDTO?, Failure>> getFolderById(String id) async{
    try {
      final query = _db.select(_db.folderItems)
        ..where((tbl) => tbl.id.equals(id));
    
      final FolderItem? record = await query.getSingleOrNull();
      
      return record != null 
          ? Result.success(FolderDriftMapper.fromData(record))
          : Result.failure(FolderReadFailure(details: 'Folder not found.'));
          
    } on SqliteException catch (e) {
        return Result.failure(FolderSqliteFailureMapper.map(e, FolderReadFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
        
    } catch (e) {
        return Result.failure(FolderReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
}



/// FolderDriftObservers: Implementación de los observadores para la persistencia de `Folder` en Drift.
class _FolderDriftObservers implements FolderPersistenceObservers {
  const _FolderDriftObservers(this._db);
  final AppDatabase _db;
  
  @override
  /// WatchAllFolders: Observa todos los `Folder` en la base de datos. Devuelve un `Stream` de listas de `FolderDTO`.
  Stream<List<FolderDTO>> watchAllFolders() {
    final Stream<List<FolderItem>> stream = _db.select(_db.folderItems).watch();
    
    return stream.map(
      (rows) => rows.map(FolderDriftMapper.fromData).toList()
    );
  }
  
  @override
  /// WatchFolderById: Observa un `Folder` por su ID en la base de datos. Devuelve un `Stream` de `FolderDTO`.
  Stream<FolderDTO> watchFolderById(String id) {
    final query = _db.select(_db.folderItems)
      ..where((tbl) => tbl.id.equals(id));
      
    final Stream<FolderItem> stream = query.watchSingle();
    return stream.map(FolderDriftMapper.fromData);
  }
}
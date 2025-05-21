// External imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/native.dart';

// Failure / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_infrastructure_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_sqlite_failure_mapper.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



/// PageDriftRepositoryAdapter: Adaptador para la persistencia de `Page` en Drift (Basado en Sqlite).
class PageDriftRepositoryAdapter implements ForPersistingPagesPort {
  const PageDriftRepositoryAdapter(this._db);
  final AppDatabase _db;
  
  @override
  PagePersistenceCommands get commands => _PageDriftCommands(_db);
  
  @override
  PagePersistenceQueries get queries => _PageDriftQueries(_db);
  
  @override
  PagePersistenceObservers get observers => _PageDriftObservers(_db);
}



/// PageDriftCommands: Implementación de los comandos para la persistencia de `Page` en Drift.
class _PageDriftCommands implements PagePersistenceCommands {
  const _PageDriftCommands(this._db);
  final AppDatabase _db;

  @override
  /// CreatePage: Crea un nuevo `Page` en la base de datos.
  Future<Result<int, Failure>> createPage(Page page) async {
    try {
      final PageDTO dto = PageDomainMapper.fromDomain(page);
      final PageItemsCompanion pageCompanion = PageDriftMapper.toCompanion(dto);
      
      final int result = await _db.into(_db.pageItems).insert(pageCompanion);
      return Result.success(result);
      
    } on SqliteException catch (e) {
      return Result.failure(PageSqliteFailureMapper.map(e, PageInsertFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(PageInsertFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  /// UpdatePage: Actualiza un `Page` existente en la base de datos.
  Future<Result<int, Failure>> updatePage(Page page) async{
    try {
      final PageDTO dto = PageDomainMapper.fromDomain(page);
      final PageItemsCompanion pageCompanion = PageDriftMapper.toCompanion(dto);
      
      final int result = await (_db.update(_db.pageItems)
        ..where((tbl) => tbl.id.equals(dto.id!))
      ).write(pageCompanion);
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(PageUpdateFailure(details: 'Page not found to update.'));
      
    } on SqliteException catch (e) {
      return Result.failure(PageSqliteFailureMapper.map(e, PageUpdateFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(PageUpdateFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  /// HardDeletePage: Elimina un `Page` de forma permanente en la base de datos.
  Future<Result<int, Failure>> hardDeletePage(String id) async {
    try {
      final int result = await (_db.delete(_db.pageItems)
        ..where((tbl) => tbl.id.equals(id))
      ).go();
      
      return result > 0 
          ? Result.success(result) 
          : Result.failure(PageDeleteFailure(details: 'Page not found to delete.'));
      
    } on SqliteException catch (e) {
      return Result.failure(PageSqliteFailureMapper.map(e, PageDeleteFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(PageDeleteFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }  
}



/// PageDriftQueries: Implementación de las consultas para la persistencia de `Page` en Drift.
class _PageDriftQueries implements PagePersistenceQueries {
  const _PageDriftQueries(this._db);
  final AppDatabase _db;
  
  @override
  /// GetAllPages: Obtiene todos los `Page` de la base de datos.
  Future<Result<List<PageDTO>?, Failure>> getAllPages() async {
    try {
      final query = _db.select(_db.pageItems);
      final List<PageItem> rows = await query.get();
      
      final List<PageDTO> pages = rows.map(PageDriftMapper.fromData).toList();
      return Result.success(pages);
      
    } on SqliteException catch (e) {
      return Result.failure(PageSqliteFailureMapper.map(e, PageReadFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(PageReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  /// GetPageById: Obtiene un `Page` por su ID.  Si no se encuentra, devuelve un error.
  Future<Result<PageDTO?, Failure>> getPageById(String id) async {
    try {
      final query = _db.select(_db.pageItems)
        ..where((tbl) => tbl.id.equals(id));
        
      final PageItem? record = await query.getSingleOrNull();
      
      return record != null 
          ? Result.success(PageDriftMapper.fromData(record)) 
          : Result.failure(PageReadFailure(details: 'Page not found.'));
      
    } on SqliteException catch (e) {
      return Result.failure(PageSqliteFailureMapper.map(e, PageReadFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
          return Result.failure(PageReadFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
}

/// PageDriftObservers: Implementación de los observadores para la persistencia de `Page` en Drift.
class _PageDriftObservers implements PagePersistenceObservers {
  const _PageDriftObservers(this._db);
  final AppDatabase _db;
  
  @override
  /// WatchAllPages: Observa todos los `Page` en la base de datos.
  Stream<List<PageDTO>> watchAllPages() {
    final Stream<List<PageItem>> stream = _db.select(_db.pageItems).watch();
    
    return stream.map(
      (rows) => rows.map(PageDriftMapper.fromData).toList()
    );
  }
  
  @override
  /// WatchPageById: Observa un `Page` por su ID.
  Stream<PageDTO> watchPageById(String id) {
    final query = _db.select(_db.pageItems)
      ..where((tbl) => tbl.id.equals(id));
      
    final Stream<PageItem> stream = query.watchSingle();
    return stream.map(PageDriftMapper.fromData);
  }
}
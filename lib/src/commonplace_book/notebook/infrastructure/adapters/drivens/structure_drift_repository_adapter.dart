// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// Failures / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_application_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_infrastructure_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_sqlite_failure_mapper.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/structure/structure_vo.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_structures_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';



class StructureDriftRepositoryAdapter implements ForPersistingStructuresPort {
  const StructureDriftRepositoryAdapter(this._db);
  final AppDatabase _db;
  
  @override
  StructurePersistenceCommands get commands => _StructureDriftCommands(_db);
  @override
  
  StructurePersistenceQueries get queries => _StructureDriftQueries(_db);
  
  @override
  StructurePersistenceObservers get observers => throw UnimplementedError();
}




class _StructureDriftCommands implements StructurePersistenceCommands {
  const _StructureDriftCommands(this._db);
  final AppDatabase _db; 
  
  @override
  Future<Result<int, Failure>> createStructureForFolder({required Structure structure, required Folder folder}) async {
    try {
      final folderDto = FolderDomainMapper.fromDomain(folder);
      final strucutureDto = StructureDomainMapper.fromDomain(structure);
      
      final folderCompanion = FolderDriftMapper.toCompanion(folderDto);
      final structureCompanion = StructureDriftMapper.toCompanion(strucutureDto);
      
      return await _db.transaction(() async {
        // ignore: unused_local_variable
        final folderId = await _db.into(_db.folderItems).insert(folderCompanion);
        final structureId = await _db.into(_db.notebookStructureItems).insert(structureCompanion);
        return Result.success(structureId);
      });
      
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureInsertFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(StructureInsertFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<int, Failure>> createStructureForPage({required Structure structure, required Page page}) async {
    try {
      final pageDto = PageDomainMapper.fromDomain(page);
      final strucutureDto = StructureDomainMapper.fromDomain(structure);
      
      final pageCompanion = PageDriftMapper.toCompanion(pageDto);
      final structureCompanion = StructureDriftMapper.toCompanion(strucutureDto);
      
      return await _db.transaction(() async {
        // ignore: unused_local_variable
        final folderId = await _db.into(_db.pageItems).insert(pageCompanion);
        final structureId = await _db.into(_db.notebookStructureItems).insert(structureCompanion);
        return Result.success(structureId);
      });
      
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureInsertFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
        return Result.failure(StructureInsertFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<int, Failure>> updateStructureItem(Structure structure) async {
    try {
      final StructureDTO dto = StructureDomainMapper.fromDomain(structure);
      final NotebookStructureItemsCompanion structureCompanion = StructureDriftMapper.toCompanion(dto);
      
      final int result = await (_db.update(_db.notebookStructureItems)
        ..where((tbl) => tbl.id.equals(dto.structureId!))
      ).write(structureCompanion);
      
      return result > 0
        ? Result.success(result)
        : Result.failure(StructureUpdateFailure(details: 'Structure not found to update.'));
        
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureUpdateFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
    
    } catch (e) {
        return Result.failure(StructureUpdateFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<int, Failure>> hardDeleteStructureItem(String structureId) async {
    try {
      final int result = await (_db.delete(_db.notebookStructureItems)
        ..where((tbl) => tbl.id.equals(structureId))
      ).go();
      
      return result > 0
        ? Result.success(result)
        : Result.failure(StructureDeleteFailure(details: 'Structure not found to delete.'));
        
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureDeleteFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
    
    } catch (e) {
        return Result.failure(StructureDeleteFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  Future<Result<void, Failure>> reorderStructureItem({
    required String structureId, 
    required int newPosition
  }) async {
    try {
      return await _db.transaction(() async {
        // 1.- Obtener el item actual.
        // Crea una consulta SELECT y añade condición WHERE.
        final selectQuery = _db.select(_db.notebookStructureItems)..where((tbl) => tbl.id.equals(structureId));  
        
        // Ejecutar y obtener resultado (puede ser null si no existe).
        final currentItem = await selectQuery.getSingleOrNull();
        
        if (currentItem == null) {
          return Result.failure(StructureReorderFailure(
            details: 'Structure item not found for reordering.'
          ));
        }
        
        final int oldPosition = currentItem.position;
        final String? parentId = currentItem.parentId;
        
        // 2.- Si la posición no cambió, no hacer nada.
        if(oldPosition == newPosition) {
          return Result.success(null);
        }
        
        // 3.- Verificar que la nueva posición sea válida.
          // Crea consulta que solo selecciona columnas específicas (no todas).
          final countQuery = _db.selectOnly(_db.notebookStructureItems);
          
          // Especificar qué columnas queremos
          countQuery.addColumns([_db.notebookStructureItems.id.count()]);
          
          // Agrega condicion WHERE para filtrar por parentId, equalsNullable maneja tanto valores null como no-null.
          countQuery.where(_db.notebookStructureItems.parentId.equalsNullable(parentId));
          
          // Ejecutar y obtener resultado. SiblingCount analiza cuantos registros tienen un mismo padre.
          final siblingCount = await countQuery.getSingle();
        
        // Total de hermanos con un mismo parentId.
        final int totalSiblings = siblingCount.read(_db.notebookStructureItems.id.count()) ?? 0;
        
        // Valida que la nueva posición no sea menor a cero o mayor o igual al total de hermanos. 
        // - Donde la primera posicion es 0 y la ultima el total - 1.
        if(newPosition < 0 || newPosition >= totalSiblings) {
          return Result.failure(StructureReorderFailure(
            details: 'Invalid position. Must be between 0 and ${totalSiblings -1}.'
          ));
        }
        
        // 4.- Reordenar elementos según si se mueve hacia arriba o hacia abajo.
        // Hay que pensar en una lista donde el primer registro esta hasta arriba y el último hasta abajo.
        if(oldPosition < newPosition) {
          // Obtener elementos que necesitan actualización.
          final elementsToUpdate = await (_db.select(_db.notebookStructureItems)
            ..where((tbl) =>
              tbl.parentId.equalsNullable(parentId) &             // Actualiza elementos del mismo contenedor padre.
              tbl.position.isBiggerThanValue(oldPosition) &       // Encuentra elementos que estan DESPUÉS del elemento original.
              tbl.position.isSmallerOrEqualValue(newPosition) &   // Y menor o igual a la nueva posición de destino.
              tbl.id.isNotValue(structureId))                     // Excluye el elemento que estamos moviendo.
          ).get();
          
          // Actualizar cada elemento individualmente. (Decrementar su posicion en 1).
          for(final element in elementsToUpdate) {
            await (_db.update(_db.notebookStructureItems)
              ..where((tbl) => tbl.id.equals(element.id))
            ).write(NotebookStructureItemsCompanion(
              position: Value(element.position - 1)
            ));
          }
        } 
        
        // OldPosition > NewPosition
        else {
          // Obtener elementos que necesitan actualización.
          final elementsToUpdate = await (_db.select(_db.notebookStructureItems)
            ..where((tbl) =>
              tbl.parentId.equalsNullable(parentId) &             // Actualiza elementos del mismo contenedor padre.
              tbl.position.isBiggerOrEqualValue(newPosition) &    // Encuentra elementos que estan en la nueva posición o DESPUÉS.
              tbl.position.isSmallerOrEqualValue(oldPosition) &   // Y menor o igual de la posicion original.
              tbl.id.isNotValue(structureId))                     // Excluye el elemento que estamos moviendo.
          ).get();
          
          // Actualizar cada elemento individualmente. (Aumentar su posicion en 1).
          for(final element in elementsToUpdate) {
            await (_db.update(_db.notebookStructureItems)
              ..where((tbl) => tbl.id.equals(element.id))
            ).write(NotebookStructureItemsCompanion(
              position: Value(element.position + 1)
            ));
          }
        }
        
        // 5.- Actualizar la posición del item objetivo.
        final updateResult = await (_db.update(_db.notebookStructureItems)
          ..where((tbl) => tbl.id.equals(structureId))
        ).write(NotebookStructureItemsCompanion(
          position: Value(newPosition),
        ));
        
        if(updateResult == 0) {
          return Result.failure(StructureReorderFailure(
            details: 'Failed to update structure item position.'
          ));
        }
      
        return Result.success(null);
      });
      
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureReorderFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
    
    } catch (e) {
        return Result.failure(StructureReorderFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
}



class _StructureDriftQueries implements StructurePersistenceQueries {
  const _StructureDriftQueries(this._db);
  final AppDatabase _db;
  
  @override
  Future<Result<List<StructureDTO>, Failure>> getNotebookStructure(String notebookId) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable)
        ..where((tbl) => tbl.notebookId.equals(notebookId))
        ..orderBy([
          (tbl) => OrderingTerm(expression: tbl.depth),
          (tbl) => OrderingTerm(expression: tbl.position),
        ]);
        
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final structureList = rows.map((row) => StructureDriftMapper.fromData(row)).toList();
      
      return Result.success(structureList);
    
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureReadFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
    
    } catch (e) {
      return Result.failure(StructureReadFailure(details: 'UNEXPECTED ERROR: ${e.toString()}.'));
    }
  }

  @override
  Future<Result<StructureDTO?, Failure>> getStructureById(String structureId) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;
      
      // 2.- Creamos el query select.
      final query = _db.select(structureTable)
        ..where((tbl) => tbl.id.equals(structureId));
      
      // 3.- Ejecutamos query y convertimos a StructureDTO (puede ser null).
      final row = await query.getSingleOrNull();
      final structureDTO = row != null
        ? StructureDriftMapper.fromData(row)
        : null;
        
      return Result.success(structureDTO);
      
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureReadFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'),
        ));
    
    } catch (e) {
        return Result.failure(StructureReadFailure(details: 'UNEXPECTED ERROR: ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<int, Failure>> getNextAvailablePosition({required String notebookId, required String? parentId}) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;   // Tabla de estructura.
      final positionColumn = structureTable.position;      // Referencia a la columna de posición.
      final maxPositionExpression = positionColumn.max();  // Función que obtiene el valor máximo de `position`.
      
      // 2.- Creamos el query selectOnly.
      final selectQuery = _db.selectOnly(structureTable); 
      selectQuery.addColumns([maxPositionExpression]);     // Añadimos la columna que nos interesa.
      
      // Filtro: Mismo notebookId.
      final notebookFilter = structureTable.notebookId.equals(notebookId);
      selectQuery.where(notebookFilter);
      
      // Filtro: Mismo parentId.
      final parentFilter = parentId == null               
        ? structureTable.parentId.isNull()
        : structureTable.parentId.equals(parentId);
      selectQuery.where(parentFilter);
      
      // 3.- Ejecutamos el query
      final queryResult = await selectQuery.getSingleOrNull();
      
      // 4.- Leemos el valor máximo de posición (puede ser null si no hay elementos hermanos).
      final int? currentMaxPosition = queryResult?.read(maxPositionExpression);
      
      // Si no hay elementos hermanos (currentMaxPosition == null) entonces nextPosition = 0.
      // Como position empieza en 0, el item 2 será currentMaxPosition (es decir 0) + 1.
      final nextPosition = currentMaxPosition != null
        ? currentMaxPosition + 1
        : 0;
        
      return Result.success(nextPosition);
    
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureInvalidPositionFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
    
    } catch (e) {
        return Result.failure(StructureInvalidPositionFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  Future<Result<int, Failure>> getDepthForNewStructureItem({required String notebookId, required String? parentId}) async {
    try {
      // 1.- Si no hay parentId, el nuevo elemento está en la raíz (depth 0).
      if(parentId == null) return Result.success(0);
      
      // 2.- Obtenemos la tabla.
      final structureTable = _db.notebookStructureItems;
      
      // 3.- Creamos el query selectOnly.
      final selectQuery = _db.selectOnly(structureTable);
      selectQuery.addColumns([structureTable.depth]);      // Añadimos la columna que nos interesa.
      
      // Filtro: Mismo notebookId.
      final notebookFilter = structureTable.notebookId.equals(notebookId);
      selectQuery.where(notebookFilter);
      
      // Filtro: Mismo parentId.
      final parentFilter = structureTable.parentId.equals(parentId);
      selectQuery.where(parentFilter);
      
      // 4.- Ejecutamos el query.
      final parentItem = await selectQuery.getSingleOrNull();
      
      // 5.- Si no existe el padre, devolvemos error.
      if(parentItem == null) {
        return Result.failure(StructureInvalidDepthFailure(
          details: 'Parent item not found. Cannot determine depth.'
        ));
      }
      
      // 6.- Leemos el valor de profundidad (depth) del padre.
      final int? parentDepth = parentItem.read(structureTable.depth);
      if(parentDepth == null) {
        return Result.failure(StructureInvalidDepthFailure(
          details: 'Parent item depth cannot be null. Cannot determine depth.'
        ));
      }
      
      final int newDepth = parentDepth + 1; // La profundidad del nuevo elemento es la del padre + 1.
      return Result.success(newDepth);
      
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureInvalidDepthFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
    
    } catch (e) {
        return Result.failure(StructureInvalidDepthFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }
  
  @override
  Future<Result<String?, Failure>> getStructureElementType(String structureId) async {
    try {
      // 1.- Obtenemos la tabla de estructura.
      final structureTable = _db.notebookStructureItems;
      
      // 2.- Creamos el query selectOnly.
      final selectQuery = _db.selectOnly(structureTable);
      selectQuery.addColumns([structureTable.type]);       // Añadimos la columna que nos interesa.
      
      // Filtro: ID de elemento.
      selectQuery.where(structureTable.id.equals(structureId));
      
      // 3.- Ejecutamos el query.
      final structureItem = await selectQuery.getSingleOrNull();
      
      // 4.- Si no existe el item, devolvemos error.
      if(structureItem == null) {
        return Result.failure(StructureNotFoundFailure(
          details: 'Structure item with id "$structureId" not found.',
        ));
      }
      
      // 5.- Leemos la columna `type`.
      final typeValue = structureItem.read(structureTable.type);
      return Result.success(typeValue);
      
    } on SqliteException catch (e) {
        return Result.failure(StructureSqliteFailureMapper.map(e, StructureNotFoundFailure(
          details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
        )));
    
    } catch (e) {
        return Result.failure(StructureNotFoundFailure(details: 'UNEXPECTED ERROR ${e.toString()}.'));
    }
  }

  @override
  Future<Result<List<StructureDTO>, Failure>> getNotebookFolders(String notebookId) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable);
      
      // Filtro: Mismo NotebookId y solo elementos tipo "folder".
      selectQuery.where((tbl) =>
        tbl.notebookId.equals(notebookId) &
        tbl.type.equals(StructureElementType.folderType.value)
      );
      
      // Criterio de Orden: Por profundidad y posición.
      selectQuery.orderBy([
        (tbl) => OrderingTerm(expression: tbl.depth),
        (tbl) => OrderingTerm(expression: tbl.position),
      ]);
      
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final folderList = rows.map((row) => StructureDriftMapper.fromData(row)).toList();
      
      return Result.success(folderList);
    
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureReadFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
    } catch (e) {
      return Result.failure(StructureReadFailure(details: 'UNEXPECTED ERROR: ${e.toString()}.'));
    }
  }

  @override
  Future<Result<List<StructureDTO>, Failure>> getNotebookPages(String notebookId) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable);
      
      // Filtro: Mismo NotebookId y solo elementos tipo "page".
      selectQuery.where((tbl) =>
        tbl.notebookId.equals(notebookId) &
        tbl.type.equals(StructureElementType.pageType.value)
      );
      
      // Criterio de Orden: Por profundidad y posición.
      selectQuery.orderBy([
        (tbl) => OrderingTerm(expression: tbl.depth),
        (tbl) => OrderingTerm(expression: tbl.position),
      ]);
      
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final pageList = rows.map((row) => StructureDriftMapper.fromData(row)).toList();
      
      return Result.success(pageList);
  
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureReadFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
      return Result.failure(StructureReadFailure(details: 'UNEXPECTED ERROR: ${e.toString()}.'));
  }
}
  
  @override
  Future<Result<List<StructureDTO>, Failure>> getChildrenOf({required String notebookId, required String? parentId}) {
    // TODO: implement getChildrenOf
    throw UnimplementedError();
  }
}
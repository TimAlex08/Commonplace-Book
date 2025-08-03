// External Imports.
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_application_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_infrastructure_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_sqlite_failure_mapper.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_structures_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';



// Constantes.
const folderType = 'folder';
const pageType = 'page';

class StructureDriftRepositoryAdapter implements ForPersistingStructuresPort {
  const StructureDriftRepositoryAdapter(this._db);
  final AppDatabase _db;
  
  @override
  StructurePersistenceCommands get commands => _StructureDriftCommands(_db);
  @override
  
  StructurePersistenceQueries get queries => _StructureDriftQueries(_db);
  
  @override
  StructurePersistenceObservers get observers => _StructureDriftObservers(_db);
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
  Future<Result<int, Failure>> reorderStructureItem({
    required String notebookId,
    required String draggedItemId,
    required int newDepth,
    required String? oldParentId,
    required String? newParentId,
    required int oldPosition,
    required int newPosition,
  }) async {
    try {
      return await _db.transaction(() async {
        int totalRowsAffected = 0;
        
        // 1.- Obtener el item arrastrado para su depth actual.
        final draggedItemEntry = await (_db.select(_db.notebookStructureItems)
              ..where((tbl) => tbl.id.equals(draggedItemId)))
            .getSingleOrNull();
        
        if(draggedItemEntry == null) {
          return Result.failure(StructureNotFoundFailure(
            details: 'Dragged item with ID $draggedItemId not found.'
          ));
        }
        
        final oldDepth = draggedItemEntry.depth;
        final depthDifference = newDepth - oldDepth;
        
        // 2.- Ajustar posiciones en la antigua lista de hermanos
        // Si el padre no ha cambiado, o si ha cambiado, necesitamos cerrar el "hueco".
        if(oldParentId == newParentId) {
          // Reordenamiento dentro del mismo padre.
          if(oldPosition < newPosition) {
            // Se movió hacia abajo: Decrementar posiciones de los elementos entre oldPosition y newPosition.
            await (_db.update(_db.notebookStructureItems)
              ..where((tbl) => oldParentId == null
                  ? tbl.parentId.isNull()
                  : tbl.parentId.equals(oldParentId))
              ..where((tbl) => tbl.notebookId.equals(notebookId))
              ..where((tbl) => tbl.position.isBetween(
                    Variable(oldPosition + 1),
                    Variable(newPosition),
                  )))
            .write(NotebookStructureItemsCompanion.custom(
              position: const CustomExpression<int>('position - 1'),
            ));
          } else if (oldPosition > newPosition) {
            // Se movió hacia arriba: Incrementar posiciones de los elementos entre newPosition y oldPosition.
            await (_db.update(_db.notebookStructureItems)
                ..where((tbl) => oldParentId == null
                    ? tbl.parentId.isNull()
                    : tbl.parentId.equals(oldParentId))
                ..where((tbl) => tbl.notebookId.equals(notebookId))
                ..where((tbl) => tbl.position.isBetween(
                      Variable(newPosition),
                      Variable(oldPosition - 1),
                    )))
              .write(NotebookStructureItemsCompanion.custom(
                position: const CustomExpression<int>('position + 1'),
              )
            );
            
          } else {
            // El padre cambió: Decrementar posiciones de los elementos posteriores al draggedItem en la *antigua* lista
            await (_db.update(_db.notebookStructureItems)
                ..where((tbl) => oldParentId == null
                    ? tbl.parentId.isNull()
                    : tbl.parentId.equals(oldParentId))
                ..where((tbl) => tbl.position.isBiggerThan(Variable(oldPosition)))
                ..where((tbl) => tbl.notebookId.equals(notebookId)))
              .write(NotebookStructureItemsCompanion.custom(
                position: const CustomExpression<int>('position - 1'),
              )
            );
            
            // --- Ajustar posiciones en la nueva lista de hermanos para hacer espacio ---
            // Incrementar posiciones de los elementos en la *nueva* lista a partir de newPosition
            await (_db.update(_db.notebookStructureItems)
                ..where((tbl) => newParentId == null
                    ? tbl.parentId.isNull()
                    : tbl.parentId.equals(newParentId))
                ..where((tbl) => tbl.position.isBiggerOrEqual(Variable(newPosition)))
                ..where((tbl) => tbl.notebookId.equals(notebookId)))
              .write(NotebookStructureItemsCompanion.custom(
                position: const CustomExpression<int>('position + 1'),
              )
            );
          }
        }
        
        // 3.- Actualizar el elemento arrastrado (parentId, position, depth).
        totalRowsAffected += await (_db.update(_db.notebookStructureItems)
          ..where((tbl) => tbl.id.equals(draggedItemId)))
          .write(NotebookStructureItemsCompanion(
            parentId: Value(newParentId),
            position: Value(newPosition),
            depth: Value(newDepth),
          )
        );
        
        // 4. Actualizar recursivamente la profundidad de todos los descendientes
        // Se usa una CTE recursiva para seleccionar todos los descendientes del `draggedItemId`.
        // Luego se actualiza su profundidad sumando `depthDifference`.
        final descendantIdsAndDepths = await _db.customSelect(
          'WITH RECURSIVE descendants AS ( '
          '  SELECT id, depth FROM notebook_structure_items WHERE parent_id = ?1 '
          '  UNION ALL '
          '  SELECT n.id, n.depth FROM notebook_structure_items n JOIN descendants d ON n.parent_id = d.id '
          ') SELECT id, depth FROM descendants;',
          variables: [Variable(draggedItemId)],
        ).get();
        
          for (final row in descendantIdsAndDepths) {
            // Lee el id como un String que acepta ser nulo (String?).
            final id = row.read<String?>('id');
            
            if(id == null) {
              continue;
            }
            
            final currentDepth = row.read<int>('depth');
            final updatedDescendantDepth = currentDepth + depthDifference;
    
            await (_db.update(_db.notebookStructureItems)
                  ..where((tbl) => tbl.id.equals(id)))
                .write(NotebookStructureItemsCompanion(
                  depth: Value(updatedDescendantDepth),
                ));
            totalRowsAffected++;
          }
          return Result.success(totalRowsAffected);
        }
      );
      
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
      final folderTable = _db.folderItems;
      final pageTable = _db.pageItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable).join([
        leftOuterJoin(
          folderTable,
          folderTable.id.equalsExp(structureTable.folderId) &
          structureTable.type.equals(folderType)
        ),
        leftOuterJoin(
          pageTable, 
          pageTable.id.equalsExp(structureTable.pageId) & 
          structureTable.type.equals(pageType)
        ),
      ])
        ..where(structureTable.notebookId.equals(notebookId))
        ..orderBy([
          OrderingTerm(expression: structureTable.depth),
          OrderingTerm(expression: structureTable.position),
        ]);
        
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final structureList = rows.map((row) {
        final structure = row.readTable(structureTable);
        final folder = row.readTableOrNull(folderTable);
        final page = row.readTableOrNull(pageTable);
        
        return StructureDriftMapper.fromData(structure, folder, page);
      }).toList();
      
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
  Future<Result<StructureDTO, Failure>> getStructureById(String structureId) async {
    try {
      // 1.- Obtenemos variables principales.
      final structureTable = _db.notebookStructureItems;
      final folderTable = _db.folderItems;
      final pageTable = _db.pageItems;
    
      // 2.- Creamos el query select.
      final query = _db.select(structureTable).join([
        leftOuterJoin(
          folderTable, 
          folderTable.id.equalsExp(structureTable.folderId) & 
          structureTable.type.equals(folderType)
        ),
        leftOuterJoin(
          pageTable, 
          pageTable.id.equalsExp(structureTable.pageId) & 
          structureTable.type.equals(pageType)
        ),
      ])
      ..where(structureTable.id.equals(structureId));
      
      // 3.- Ejecutamos query y convertimos a StructureDTO (puede ser null).
      final row = await query.getSingleOrNull();
      
      // 4.- Verificamos su se encontró el elemento y mapeamos.
      if (row == null) {
        // Si no se encontró la estructura, devolvemos un fallo.
        return Result.failure(StructureNotFoundFailure(
          details: 'Structure with ID $structureId not found.',
        ));
      }
      
      final structureDTO = StructureDriftMapper.fromData(
        row.readTable(structureTable),
        row.readTableOrNull(folderTable),
        row.readTableOrNull(pageTable),
      );
        
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
      final parentFilter = structureTable.id.equals(parentId);
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
      final folderTable = _db.folderItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable).join([
        leftOuterJoin(
          folderTable,
          folderTable.id.equalsExp(structureTable.folderId),
        )
      ]);
      
      // Filtro: Mismo NotebookId y solo elementos tipo "folder".
      selectQuery.where(
        structureTable.notebookId.equals(notebookId) &
        structureTable.type.equals(folderType)
      );
      
      // Criterio de Orden: Por profundidad y posición.
      selectQuery.orderBy([
        OrderingTerm(expression: structureTable.depth),
        OrderingTerm(expression: structureTable.position),
      ]);
      
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final folderList = rows.map((row) {
        final structure = row.readTable(structureTable);
        final folder = row.readTableOrNull(folderTable);
        
        return StructureDriftMapper.fromData(structure, folder, null);
      }).toList();
      
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
      final pageTable = _db.pageItems;
      
      // 2.- Creamos el query select.
      final selectQuery = _db.select(structureTable).join([
        leftOuterJoin(
          pageTable,
          pageTable.id.equalsExp(structureTable.folderId)
        ),
      ]);
      
      // Filtro: Mismo NotebookId y solo elementos tipo "page".
      selectQuery.where(
        structureTable.notebookId.equals(notebookId) &
        structureTable.type.equals(pageType)
      );
      
      // Criterio de Orden: Por profundidad y posición.
      selectQuery.orderBy([
        OrderingTerm(expression: structureTable.depth),
        OrderingTerm(expression: structureTable.position),
      ]);
      
      // 3.- Ejecutamos el query y convertimos a StructureDTO.
      final rows = await selectQuery.get();
      final pageList = rows.map((row) {
        final structure = row.readTable(structureTable);
        final page = row.readTableOrNull(pageTable);
        
        return StructureDriftMapper.fromData(structure, null, page);
      }).toList();
      
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
  Future<Result<List<StructureDTO>, Failure>> getDescendantStructures(String parentId) async {
    try {
      // WITH RECURSIVE descendants AS: Inicia una CTE (Common Table Expression) recursiva, le damos
      // el nombre de descendants. La parte base obtiene los primeros resultados, la parte recursiva
      // que sigue explorando a partir de los resultados anteriores.
      //
      // SELECT * 
      // ROM notebook_structure_items 
      // WHERE parent_id = ?1
      // Esta es la parte base de la recursión, selecciona todos los registros cuya parentId coinicida
      // el id que pasamos como parámetros (?1, que es Variable(parentId) en Dart).
      //
      // SELECT n.* 
      // FROM notebook_structure_items n 
      // JOIN descendants d ON n.parent_id = d.structure_id
      // Esta es la parte recursiva. Une `JOIN` la tabla `notebook_structure_items` consigo misma de 
      // manera recursiva. Por cada registro ya encontrado en la CTE `descendants`, busca todos los
      // elementos que tengan a ese registro como padre (n.parent_id = d.structure_id). Asi encadenando
      // hijos, nietos, bisnietos, etc. hasta que ya no haya más descendientes.
      //
      // SELECT * FROM descendants;
      // Esta es la consulta principal que retorna los resultados. Después de que la CTE `descendants` se
      // ha construido con todos los descendientes (de forma recursiva), se seleccionan todos sus registros.
      final results = await _db.customSelect(
        'WITH RECURSIVE descendants AS ( '
        '  SELECT * FROM notebook_structure_items WHERE parent_id = ?1 '
        '  UNION ALL '
        '  SELECT n.* FROM notebook_structure_items n JOIN descendants d ON n.parent_id = d.id '
        ') SELECT * FROM descendants;',
        variables: [Variable(parentId)],
      ).get();
      
      final List<StructureDTO> dtos = results.map((row) => StructureDriftMapper.fromQueryRow(row)).toList();
      
      return Result.success(dtos);
    } on SqliteException catch (e) {
      return Result.failure(StructureSqliteFailureMapper.map(e, StructureQueryFailure(
        details: 'SQLITE(${e.extendedResultCode}): ${e.message}.'
      )));
      
    } catch (e) {
      return Result.failure(StructureQueryFailure(details: 'UNEXPECTED ERROR: ${e.toString()}.'));
    }
  }
}



class _StructureDriftObservers implements StructurePersistenceObservers {
  const _StructureDriftObservers(this._db);
  final AppDatabase _db;
  
  @override
  Stream<List<StructureDTO>> watchNotebookStructure(String notebookId) {
    final structureTable = _db.notebookStructureItems;
    final folderTable = _db.folderItems;
    final pageTable = _db.pageItems;
    
    final query = _db.select(structureTable).join([
      leftOuterJoin(
        folderTable, 
        folderTable.id.equalsExp(structureTable.folderId) & 
        structureTable.type.equals(folderType)
      ),
      leftOuterJoin(
        pageTable, 
        pageTable.id.equalsExp(structureTable.pageId) & 
        structureTable.type.equals(pageType)
      )
    ])
    ..where(structureTable.notebookId.equals(notebookId))
    ..orderBy([
      OrderingTerm(expression: structureTable.depth),
      OrderingTerm(expression: structureTable.position)
    ]);
    
    return query.watch().map(
      (rows) => rows.map((row) {
        final structure = row.readTable(structureTable);
        final folder = row.readTableOrNull(folderTable);
        final page = row.readTableOrNull(pageTable);
        
        return StructureDriftMapper.fromData(structure, folder, page);
      }).toList()
    );
  }
  
  @override
  Stream<StructureDTO?> watchStructureItem(String structureId) {
    final structureTable = _db.notebookStructureItems;
    final folderTable = _db.folderItems;
    final pageTable = _db.pageItems;
    
    final query = _db.select(structureTable).join([
      leftOuterJoin(
        folderTable, 
        folderTable.id.equalsExp(structureTable.folderId) & 
        structureTable.type.equals(folderType)
      ),
      leftOuterJoin(
        pageTable, 
        pageTable.id.equalsExp(structureTable.pageId) & 
        structureTable.type.equals(pageType)
      ),
    ])
    ..where(structureTable.id.equals(structureId));
    
    return query.watchSingleOrNull().map(
      (row) => row != null
        ? StructureDriftMapper.fromData(
            row.readTable(structureTable),
            row.readTableOrNull(folderTable),
            row.readTableOrNull(pageTable),
          )
        : null
    );
  }
}
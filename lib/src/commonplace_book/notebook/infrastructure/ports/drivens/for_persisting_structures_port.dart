// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';



abstract class ForPersistingStructuresPort {
  StructurePersistenceCommands get commands;
  StructurePersistenceQueries get queries;
  StructurePersistenceObservers get observers;
}

abstract class StructurePersistenceCommands {
  Future<Result<int, Failure>> createStructureForFolder({required Structure structure, required Folder folder});
  Future<Result<int, Failure>> createStructureForPage({required Structure structure, required Page page});
  Future<Result<int, Failure>> updateStructureItem(Structure structure);
  Future<Result<int, Failure>> hardDeleteStructureItem(String structureId);
  
  /// ReorderStructureItem: Realiza la actualización de la posición, padre, y profundidad de un elemento 
  /// y reajusta las posiciones de los elementos afectados.
  Future<Result<int, Failure>> reorderStructureItem({
    required String notebookId,
    required String draggedItemId,
    required int newDepth,
    required String? oldParentId,
    required String? newParentId,
    required int oldPosition,
    required int newPosition,
  });
}

abstract class StructurePersistenceQueries {
  Future<Result<List<StructureDTO>, Failure>> getNotebookStructure(String notebookId);
  Future<Result<StructureDTO, Failure>> getStructureById(String structureId);
  
  Future<Result<List<StructureDTO>, Failure>> getNotebookFolders(String notebookId);
  Future<Result<List<StructureDTO>, Failure>> getNotebookPages(String notebookId);
  
  /// GetNextAvailablePosition Obtener la próxima posición disponible para un nuevo elemento.
  Future<Result<int, Failure>> getNextAvailablePosition({required String notebookId, required String? parentId});
  
  /// GetDepthForNewStructureItem: Obtener la profundidad para un nuevo elemento de estructura.
  /// - Si `parentId` es `null`, se asume que es un elemento de nivel raíz, por lo que la profundidad es 0.
  /// - Si `parentId` no es `null`, se obtiene la profundidad del elemento padre y se incrementa en 1.
  Future<Result<int, Failure>> getDepthForNewStructureItem({required String notebookId, required String? parentId});
  
  /// GetStructureElementType: Obtener el tipo de un elemento de estructura específico.
  Future<Result<String?, Failure>> getStructureElementType(String structureId);
  
  /// GetDescendantStructures: Obtener todos los descendientes de un elemento de estructura.
  Future<Result<List<StructureDTO>, Failure>> getDescendantStructures(String parentId);
}

abstract class StructurePersistenceObservers {
  Stream<List<StructureDTO>> watchNotebookStructure(String notebookId);
  Stream<StructureDTO?> watchStructureItem(String notebookId);
}
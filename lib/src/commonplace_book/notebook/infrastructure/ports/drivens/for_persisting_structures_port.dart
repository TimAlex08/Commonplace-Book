// Failures / Result
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
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
  
  /// ReorderStructureItem: Reordenar un elemento de la estructura dentro de su mismo nivel.
  Future<Result<void, Failure>> reorderStructureItem({required String structureId, required int newPosition});
}

abstract class StructurePersistenceQueries {
  Future<Result<List<StructureDTO>, Failure>> getNotebookStructure(String notebookId);
  Future<Result<StructureDTO?, Failure>> getStructureById(String structureId);
  
  /// GetChildrenOf: Obtener los hijos de un elemento padre específico. Si `parentId` es `null`, se obtienen los elementos de nivel raíz.
  Future<Result<List<StructureDTO>, Failure>> getChildrenOf({required String notebookId, required String? parentId});
  
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
}

abstract class StructurePersistenceObservers {
  Stream<List<StructureDTO>> watchNotebookStructure(String notebookId);
  Stream<StructureDTO?> watchStructureItem(String notebookId);
  
  /// WatchChildrenOf: Observar los hijos de un elemento padre específico. Si `parentId` es `null`, se obtienen los elementos de nivel raíz.
  Stream<List<StructureDTO>> watchChildrenOf({required String notebookId,required String? parentId});
  
  Stream<List<StructureDTO>> watchFolders(String notebookId);
  Stream<List<StructureDTO>> watchPages(String notebookId);
}
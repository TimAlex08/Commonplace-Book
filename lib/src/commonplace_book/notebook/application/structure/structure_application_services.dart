// External Imports.
import 'package:uuid/v4.dart';

// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_application_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/structure/structure_element_type.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_structures_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_structures_port.dart';



// Constantes.
const kFolder = 'folder';
const kPage = 'page';

class StructureApplicationServices implements ForManagingStructuresPort {
  const StructureApplicationServices({
    required ForPersistingNotebooksPort notebookRepo,
    required ForPersistingStructuresPort structureRepo,
    required ForPersistingFoldersPort folderRepo,
    required ForPersistingPagesPort pageRepo,
  })  : _notebookRepo = notebookRepo,
        _structureRepo = structureRepo,
        _folderRepo = folderRepo,
        _pageRepo = pageRepo;
  
  final ForPersistingNotebooksPort _notebookRepo;
  final ForPersistingStructuresPort _structureRepo;
  final ForPersistingFoldersPort _folderRepo;
  final ForPersistingPagesPort _pageRepo;
  
  @override
  StructureManagementCommands get command => _StructureCommandHandler(
    notebookRepo: _notebookRepo,
    structureRepo: _structureRepo,
    folderRepo: _folderRepo,
    pageRepo: _pageRepo,
  );

  @override
  StructureManagementQueries get query => _StructureQueriesHandler(_structureRepo);

  @override
  StructureManagementObservers get observer => _StructureObserverHandler(_structureRepo);
}



class _StructureCommandHandler implements StructureManagementCommands {
  const _StructureCommandHandler({
    required ForPersistingNotebooksPort notebookRepo,
    required ForPersistingStructuresPort structureRepo,
    required ForPersistingFoldersPort folderRepo,
    required ForPersistingPagesPort pageRepo,
  })  : _notebookRepo = notebookRepo,
        _structureRepo = structureRepo,
        _folderRepo = folderRepo,
        _pageRepo = pageRepo;
  
  final ForPersistingStructuresPort _structureRepo;
  final ForPersistingNotebooksPort _notebookRepo;
  final ForPersistingFoldersPort _folderRepo;
  final ForPersistingPagesPort _pageRepo;
  
  @override
  Future<Result<int, List<Failure>>> createStructureItem({required StructureDTO structureDto, required String title}) async { 
    final failures = <Failure>[];
    
    final notebookId = structureDto.notebookId;
    final parentId = structureDto.parentId;
    final type = structureDto.type;
    
    // 1.- Verifica que el Notebook exista.
    final notebookResult = await _notebookRepo.queries.getNotebookById(notebookId);
    
    if (notebookResult.isFailure) {
      failures.add(StructureNotebookNotFoundFailure(
        details: 'No notebook found with id $notebookId.',
      ));
      return Result.failure(failures);
    }
    
    // 2.- Verifica que la referencia al padre pertenezca a un Folder.
    // Si parentId es null, se considera que es un elemento de nivel raíz y el código continúa.
    if(parentId != null) {
      final parentTypeResult = await _structureRepo.queries.getStructureElementType(parentId);
      if(parentTypeResult.isFailure) {
        failures.add(parentTypeResult.getFailure());
        return Result.failure(failures);
      }
      
      final parentType = parentTypeResult.getSuccess();
      if(parentType != kFolder) {
        failures.add(StructureParentCannotBePageFailure(
          details: 'ParentId provided belongs to a Page, but it should be a Folder.',
        ));
        return Result.failure(failures);
      }
    }
    
    // 3.- Crear Folder o Page desde DTO → Params → Entity.
    Folder? folder;
    Page? page;
    String entityId;
    
    switch(type) {
      case kFolder:
        final folderDto = FolderDTO(
          id: UuidV4().generate(),
          name: title
        );
        final folderParams = FolderDomainMapper.toParams(folderDto);
        final folderResult = Folder.create(folderParams);

        if (folderResult.isFailure) {
          failures.addAll(folderResult.getFailure());
          return Result.failure(failures);
        }
    
        folder = folderResult.getSuccess();
        entityId = folder.id.value;
        break;
        
      case kPage:
        final pageDto = PageDTO(
          id: UuidV4().generate(),
          title: title,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        final pageParams = PageDomainMapper.toParams(pageDto);
        final pageResult = Page.create(pageParams);
    
        if (pageResult.isFailure) {
          failures.addAll(pageResult.getFailure());
          return Result.failure(failures);
        }
    
        page = pageResult.getSuccess();
        entityId = page.id.value;
        break;
    
      default:
        failures.add(StructureInvalidTypeFailure());
        return Result.failure(failures);
    }

    // 4.- Obtener recursos para crear un Structure válido.
    final positionResult = await _structureRepo.queries.getNextAvailablePosition(notebookId: notebookId, parentId: parentId);
    final depthResult = await _structureRepo.queries.getDepthForNewStructureItem(notebookId: notebookId, parentId: parentId);
    
    if(positionResult.isFailure) failures.add(positionResult.getFailure());
    if(depthResult.isFailure) failures.add(depthResult.getFailure());
    
    if(failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    final position = positionResult.getSuccess();
    final depth = depthResult.getSuccess();
    
    // 5.- Crear StructureDTO → Params → Entidad.
    final completedDto = StructureDTO(
      structureId: UuidV4().generate(),
      notebookId: notebookId,
      parentId: parentId,
      type: type,
      folderId: type == StructureElementType.folderType.value
        ? entityId
        : null,
      pageId: type == StructureElementType.pageType.value
        ? entityId
        : null,
      position: position,
      depth: depth,
    );
    
    final structureParams = StructureDomainMapper.toParams(completedDto);
    final structureResult = type == StructureElementType.folderType.value
      ? Structure.createForFolder(structureParams)
      : Structure.createForPage(structureParams);
      
    if(structureResult.isFailure) failures.addAll(structureResult.getFailure());
    final structure = structureResult.getSuccess();
    
    // 6.- Persistencia (transacción Folder/Page + Structure).
    if (type == StructureElementType.folderType.value && folder != null) {
      final result = await _structureRepo.commands.createStructureForFolder(
        structure: structure,
        folder: folder,
      );
      
      return result.fold(
        (row) => Result.success(row),
        (failure) => Result.failure([failure]),
      );
      
    } else if (type == StructureElementType.pageType.value && page != null) {
      final result = await _structureRepo.commands.createStructureForPage(
        structure: structure,
        page: page,
      );
      
      return result.fold(
        (row) => Result.success(row),
        (failure) => Result.failure([failure]),
      );
    } else {
        throw StateError('Unreachable: CreateStructureItemUseCase failed to handle all possible cases.');
    }
  }

  // TODO: Revisar si eliminar este método.
  @override
  Future<Result<int, List<Failure>>> updateStructureItemTitle({required String structureId, required String newTitle}) async {
    final failures = <Failure>[];
    
    // 1.- Verifica que el StructureItem exista.
    final structureResult = await _structureRepo.queries.getStructureById(structureId);
    if (structureResult.isFailure) {
      failures.add(structureResult.getFailure());
      return Result.failure(failures);
    }
    
    final structure = structureResult.getSuccess();
    
    // 3.- Validar el nuevo titulo.
    if(structure.type == StructureElementType.folderType.value) {
      final folderId = structure.folderId;
      if(folderId == null) throw StateError('Expected folderId to be present for folder type structure');
      
      final folderResult = await _folderRepo.queries.getFolderById(folderId);
      if (folderResult.isFailure) {
        failures.add(folderResult.getFailure());
        return Result.failure(failures);
      }
      
      final previousFolder = folderResult.getSuccess()!;
      final updateFolderDto = previousFolder.copyWith(name: newTitle);
      final updateFolderParams = FolderDomainMapper.toParams(updateFolderDto);
      
      // Crear un nuevo Folder con el titulo actualizado.
      final validateFolder = Folder.create(updateFolderParams);
      
      if(validateFolder.isFailure) {
        failures.addAll(validateFolder.getFailure());
        return Result.failure(failures);
      }
      
      final validUpdatedFolder = validateFolder.getSuccess();
      final result = await _folderRepo.commands.updateFolder(validUpdatedFolder);
      return result.fold(
        (row) => Result.success(row),
        (failure) => Result.failure([failure]),
      );
    } else if (structure.type == StructureElementType.pageType.value) {
      final pageId = structure.pageId;
      if (pageId == null) throw StateError('Expected pageId to be present for page type structure');
      
      final pageResult = await _pageRepo.queries.getPageById(pageId);
      if (pageResult.isFailure) {
        failures.add(pageResult.getFailure());
        return Result.failure(failures);
      }
    
      final previousPage = pageResult.getSuccess()!;
      final updatePageDto = previousPage.copyWith(title: newTitle);
      final updatePageParams = PageDomainMapper.toParams(updatePageDto);
    
      final validatePage = Page.create(updatePageParams);
    
      if (validatePage.isFailure) {
        failures.addAll(validatePage.getFailure());
        return Result.failure(failures);
      }
    
      final validUpdatedPage = validatePage.getSuccess();
      final result = await _pageRepo.commands.updatePage(validUpdatedPage);
      return result.fold(
        (row) => Result.success(row),
        (failure) => Result.failure([failure]),
      );
    } else {
       throw StateError('Unsupported structure type: ${structure.type}');
    }
  }

  @override
  Future<Result<void, List<Failure>>> hardDeleteStructureItem(String structureId) {
    // TODO: implement hardDeleteStructureItem
    throw UnimplementedError();
  }

  @override
  Future<Result<int, List<Failure>>> reorderStructureItem({
    required String notebookId,
    required String draggedItemId,
    required String? newParentId,
    required int newPosition,
  }) async {
    final failures = <Failure>[];
    
    // 1.- Validar que el `draggedItemId` exista.
    final draggedItemResult = await _structureRepo.queries.getStructureById(draggedItemId);
    if(draggedItemResult.isFailure) {
      failures.add(draggedItemResult.getFailure());
      return Result.failure(failures);
    }
    final draggedItem = draggedItemResult.getSuccess();
    
    // 2.- Validar que el `newParentId` (si no es null) exista y sea una carpeta.
    StructureDTO? newParent;
    if(newParentId != null) {
      final newParentResult = await _structureRepo.queries.getStructureById(newParentId);
      if(newParentResult.isFailure) {
        failures.add(newParentResult.getFailure());
        return Result.failure(failures);
      }
      
      newParent = newParentResult.getSuccess();
      if(newParent.type != kFolder) {
        failures.add(StructureParentCannotBePageFailure(
          details: 'New parent must be a folder, but it is a page.'
        ));
        return Result.failure(failures);
      }
    }
    
    // 3.- Prevenir movimientos inválidos (un elemento a sí mismo o a uno de sus descendientes).
    if(newParentId == draggedItemId) {
      failures.add(StructureReorderFailure(
        details: 'Cannot move an item into itself.'
      ));
      return Result.failure(failures);
    }
    
    // Si `newParentId` no es nulo, necesitamos obtener todos los descendientes del `draggedItemId`.
    // para asegurarnos de que `newParentId` no sea uno de ellos.
    if(newParentId != null) {
      final descendantsResult = await _structureRepo.queries.getDescendantStructures(draggedItemId);
      if(descendantsResult.isFailure) {
        failures.add(descendantsResult.getFailure());
        return Result.failure(failures);
      }
      
      final descendantIds = descendantsResult.getSuccess().map((dto) => dto.structureId).toSet();
      if(descendantIds.contains(newParentId)) {
        failures.add(StructureReorderFailure(
          details: 'Cannot move an item into its own descendant.'
        ));
      }
    }
    
    // 4.- Calcular la nueva profundidad del elemento arrastrado.
    // La profundidad de un elemento raíz es 0. Si el padre es null, la profundidad es 0.
    // Si tiene un padre, su profundidad es la del padre + 1.
    final newDepth = (newParent?.depth ?? -1) + 1;
    
    // Verificación explicita para position antes de usarlos, ya que son vitales
    // en la operación de reordenamiento.
    if (draggedItem.position == null) {
      failures.add(StructureReorderFailure(
        details: 'Dragged item $draggedItemId has no position defined and cannot be reordered.',
      ));
      return Result.failure(failures);
    }
    
    final oldPosition = draggedItem.position!;
    
    // 5.- Delegar la operación de reordenamiento a la capa de persistencia.
    // Esta operación se ejecutará como una transacción a nivel de DB.
    final updateResult = await _structureRepo.commands.reorderStructureItem(
      notebookId: notebookId,
      draggedItemId: draggedItemId,
      newDepth: newDepth,
      oldParentId: draggedItem.parentId,
      newParentId: newParentId,
      oldPosition: oldPosition,
      newPosition: newPosition
    );
    
    return updateResult.fold(
      (rowsAffected) => Result.success(rowsAffected),
      (failure) => Result.failure([failure]),
    );
  }
}



class _StructureQueriesHandler implements StructureManagementQueries {
  const _StructureQueriesHandler(this._structureRepo);
  final ForPersistingStructuresPort _structureRepo;
  
  @override
  Future<Result<List<StructureDTO>, List<Failure>>> getNotebookStructure(String notebookId) async {
    // 1.- Obtiene todos los elementos de Structure de la libreta requerida de la base de datos.
    final result = await _structureRepo.queries.getNotebookStructure(notebookId);
    
    return result.fold(
      (structures) => Result.success(structures),
      (failures) => Result.failure([failures])
    );
  }

  @override
  Future<Result<StructureDTO?, List<Failure>>> getStructureById(StructureDTO structureDto) {
    // TODO: implement getStructureById
    throw UnimplementedError();
  }
}



class _StructureObserverHandler implements StructureManagementObservers {
  const _StructureObserverHandler(this._structureRepo);
  final ForPersistingStructuresPort _structureRepo;
  
  @override
  Stream<List<StructureDTO>> watchNotebookStructure(String notebookId) {
    return _structureRepo.observers.watchNotebookStructure(notebookId);
  }

  @override
  Stream<StructureDTO?> watchStructureById(String structureId) {
    return _structureRepo.observers.watchStructureItem(structureId);
  }
}
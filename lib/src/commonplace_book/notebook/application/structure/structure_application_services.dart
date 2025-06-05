// External Imports
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';
import 'package:uuid/v4.dart';

// Failures / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_application_failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/structure/structure_element_type.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_structures_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_structures_port.dart';



class StructureApplicationServices implements ForManagingStructuresPort {
  const StructureApplicationServices(this._notebookRepo, this._structureRepo, this._folderRepo, this._pageRepo);
  final ForPersistingNotebooksPort _notebookRepo;
  final ForPersistingStructuresPort _structureRepo;
  final ForPersistingFoldersPort _folderRepo;
  final ForPersistingPagesPort _pageRepo;
  
  @override
  StructureManagementCommands get command => _StructureCommandHandler(_notebookRepo, _structureRepo, _folderRepo, _pageRepo);

  @override
  // TODO: implement observer
  StructureManagementObservers get observer => throw UnimplementedError();

  @override
  // TODO: implement query
  StructureManagementQueries get query => throw UnimplementedError();
}



class _StructureCommandHandler implements StructureManagementCommands {
  const _StructureCommandHandler(this._notebookRepo, this._structureRepo, this._folderRepo, this._pageRepo);
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
        details: 'No notebook found with id $notebookId',
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
      if(parentType != StructureElementType.folderType.value) {
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
    
    // Validar que type no sea null o vacio.
    if (type == StructureElementType.folderType.value) {
      final folderDto = FolderDTO(name: title);
      final folderParams = FolderDomainMapper.toParams(folderDto);
      final folderResult = Folder.create(folderParams);
      if (folderResult.isFailure) {
        failures.addAll(folderResult.getFailure());
        return Result.failure(failures);
      }
      folder = folderResult.getSuccess();
      entityId = folder.id.value;
    } else {
      final pageDto = PageDTO(title: title);
      final pageParams = PageDomainMapper.toParams(pageDto);
      final pageResult = Page.create(pageParams);
      if (pageResult.isFailure) {
        failures.addAll(pageResult.getFailure());
        return Result.failure(failures);
      }
      page = pageResult.getSuccess();
      entityId = page.id.value;
    }
    
    // 3.- Obtener recursos para crear un Structure Valido
    final positionResult = await _structureRepo.queries.getNextAvailablePosition(notebookId: notebookId, parentId: parentId);
    final depthResult = await _structureRepo.queries.getDepthForNewStructureItem(notebookId: notebookId, parentId: parentId);
    
    if(positionResult.isFailure) failures.add(positionResult.getFailure());
    if(depthResult.isFailure) failures.add(depthResult.getFailure());
    
    if(failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    final position = positionResult.getSuccess();
    final depth = depthResult.getSuccess();
    
    // 4.- Crear StructureDTO → Params → Entidad
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
    
    // 5.- Persistencia (transacción Folder/Page + Structure).
    if (type == StructureElementType.folderType.value && folder != null) {
      final result = await _structureRepo.commands.createStructureForFolder(
        structure: structure,
        folder: folder,
      );
      
      return result.fold(
        Result.success,
        (failure) => Result.failure([failure]),
      );
      
    } else if (type == StructureElementType.pageType.value && page != null) {
      final result = await _structureRepo.commands.createStructureForPage(
        structure: structure,
        page: page,
      );
      
      return result.fold(
        Result.success,
        (failure) => Result.failure([failure]),
      );
    } else {
        throw StateError('Unreachable: CreateStructureItemUseCase failed to handle all possible cases.');
    }
  }

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
    
    if(structure == null) {
      failures.add(StructureNotFoundFailure(
        details: 'No structure item found with id $structureId',
      ));
      return Result.failure(failures);
    }
    
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
  Future<Result<void, List<Failure>>> reorderStructureItem({required StructureDTO structureDto, required int newPosition}) {
    // TODO: implement reorderStructureItem
    throw UnimplementedError();
  }
}
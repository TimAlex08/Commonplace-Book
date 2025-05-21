// Value Objects
// import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

import '../value_objects/notebook_structure/structure_vo.dart';



/// NotebookStructure: Representa la estructura de una libreta. 
/// La estructura puede contener carpetas y páginas, cada elemento contiene:
/// - NotebookStructureId: ID único para cada elemento de la estructura.
/// - ParentID: ID del elemento padre (puede ser nulo si es la raíz).
/// - NotebookID: Referencia a una única libreta
/// - ElementID: ID del elemento (puede ser una carpeta o una página).
/// - Position relativa: Posición del elemento dentro de la libreta.
/// - Depth: Profundidad del elemento en la estructura.
class NotebookStructure {
  const NotebookStructure._({
    required this.id,
    required this.notebookId,
    required this.parentId,
    required this.elementId,
    required this.position,
    required this.depth,
  });
  
  final StructureId id;
  final StructureNotebookReference notebookId;
  final StructureParentId? parentId;
  final StructureElementReference elementId;    // Element hace referencia a un pageId o a un folderId
  final StructurePosition position;
  final StructureDepth depth;
  
  /// CreateFolder: Crea una estructura de tipo carpeta dentro de una libreta.
  /// Valida los parámetros y delega la lógica comun al método privado `_create`.
  static Result<NotebookStructure, List<DomainFailure>> createFolder({
    required NotebookStructureParams params,
    required int? parentDepth,
    required bool parentIsFolder,
  }) {
    return _create(
      params: params, 
      parentIsFolder: parentIsFolder, 
      validateElement: StructureElementReference.forFolder, 
      validateDepth: StructureDepth.validateFolder
    );
  }
  
  /// CreatePage: Crea una estructura de tipo página dentro de una libreta.
  /// Valida los parámetros y delega la lógica común al método privado `_create`.
  static Result<NotebookStructure, List<DomainFailure>> createPage({
    required NotebookStructureParams params,
    required int? parentDepth,
    required bool parentIsFolder,
  }) {
    return _create(
      params: params,
      parentIsFolder: parentIsFolder,
      validateElement: StructureElementReference.forPage,
      validateDepth: StructureDepth.validatePage,
    );
  }
  
  
  /// _Create: Lógica común para crear una estructura (carpeta o página).
  /// Aplica validaciones y devuelve un resultado exitoso o con fallos.
  static Result<NotebookStructure, List<DomainFailure>> _create({
    required NotebookStructureParams params,
    required bool parentIsFolder,
    required Result<StructureElementReference, List<DomainFailure>> Function(String?) validateElement,
    required Result<StructureDepth, List<DomainFailure>> Function(int?) validateDepth,
  }) {
    final failures = <DomainFailure>[];
    
    // Parámetros para parentId
    final parentId = params.parentId;
    final isFolder = parentId != null ? parentIsFolder : true;

    // ----- Validaciones de parametros ----- //
    final idResult = StructureId.validate(params.structureId);
    final notebookIdResult = StructureNotebookReference.validate(params.notebookId);
    final parentIdResult = StructureParentId.validate(id: parentId, isFolder: isFolder);
    final elementResult = validateElement(params.folderId ?? params.pageId);
    final positionResult = StructurePosition.validate(params.position);
    final depthResult = validateDepth(params.depth);

    // ----- Acumular errores si hay fallos en la validaciones ----- //
    if (idResult.isFailure) failures.addAll(idResult.getFailure());
    if (parentIdResult.isFailure) failures.addAll(parentIdResult.getFailure());
    if (notebookIdResult.isFailure) failures.addAll(notebookIdResult.getFailure());
    if (elementResult.isFailure) failures.addAll(elementResult.getFailure());
    if (positionResult.isFailure) failures.addAll(positionResult.getFailure());
    if (depthResult.isFailure) failures.addAll(depthResult.getFailure());

    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) return Result.failure(failures);

    // Si no hay errores, crea un objeto válido NotebookStructure.
    return Result.success(NotebookStructure._(
      id: idResult.getSuccess(),
      parentId: parentIdResult.getSuccess(),
      notebookId: notebookIdResult.getSuccess(),
      elementId: elementResult.getSuccess(),
      position: positionResult.getSuccess(),
      depth: depthResult.getSuccess(),
    ));
  }
}



/// NotebookStructureParams: Clase que representa los parámetros necesarios para crear un `NotebookStructure`.
class NotebookStructureParams {
  const NotebookStructureParams({
    this.type, 
    this.structureId, 
    this.parentId, 
    this.notebookId, 
    this.folderId, 
    this.pageId, 
    this.position, 
    this.depth,
  });
  
  final String? type;
  final String? structureId;
  final String? parentId;
  final String? notebookId;
  final String? folderId;
  final String? pageId;
  final int? position;
  final int? depth;
}
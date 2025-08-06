// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Value Objects.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/structure/structure_vo.dart';



/// Structure: Representa la estructura de una libreta. 
/// La estructura puede contener carpetas y páginas, cada elemento contiene:
/// - Id: ID único para cada elemento de la estructura.
/// - NotebookID: Referencia a una única libreta.
/// - ParentID: ID del elemento padre (puede ser nulo si es la raíz).
/// - ElementID: ID del elemento (puede ser una carpeta o una página).
/// - Position relativa: Posición del elemento dentro de la libreta.
/// - Depth: Profundidad del elemento en la estructura.
class Structure {
  const Structure._({
    required this.id,
    required this.notebookId,
    this.parentId,
    required this.elementId,
    required this.type,
    required this.position,
    required this.depth,
  });
  
  final StructureId id;
  final StructureNotebookReference notebookId;
  final StructureParentId? parentId;
  final StructureElementReference elementId;    // Element hace referencia a un pageId o a un folderId.
  final StructureElementType type;
  final StructurePosition position;
  final StructureDepth depth;
  
  /// CreateForFolder: Crea una estructura para una carpeta.
  static Result<Structure, List<DomainFailure>> createForFolder(StructureParams params) {
    final failures = <DomainFailure>[];
    
    // Validaciones específicas para la carpeta.
    final structureIdResult = StructureId.validate(params.structureId);
    final notebookIdResult = StructureNotebookReference.validate(params.notebookId);
    final parentIdResult = StructureParentId.validate(params.parentId);
    final typeResult = StructureElementType.validate(params.type);
    final elementResult = StructureElementReference.forFolder(params.folderId);
    final positionResult = StructurePosition.validate(params.position);
    final depthResult = StructureDepth.validateFolder(params.depth);
    
    // Acumular errores.
    if (structureIdResult.isFailure) failures.addAll(structureIdResult.getFailure());
    if (notebookIdResult.isFailure) failures.addAll(notebookIdResult.getFailure());
    if (parentIdResult.isFailure) failures.addAll(parentIdResult.getFailure());
    if (typeResult.isFailure) failures.addAll(typeResult.getFailure());
    if (elementResult.isFailure) failures.addAll(elementResult.getFailure());
    if (positionResult.isFailure) failures.addAll(positionResult.getFailure());
    if (depthResult.isFailure) failures.addAll(depthResult.getFailure());
    
    return Result.success(Structure._(
      id: structureIdResult.getSuccess(),
      notebookId: notebookIdResult.getSuccess(),
      parentId: parentIdResult.getSuccess(),
      elementId: elementResult.getSuccess(),
      type: typeResult.getSuccess(),
      position: positionResult.getSuccess(),
      depth: depthResult.getSuccess(),
    ));
  }
  
  
  
  /// CreateForPage: Crea una estructura para una página.
  static Result<Structure, List<DomainFailure>> createForPage(StructureParams params) {
    final failures = <DomainFailure>[];
    
    // Validaciones específicas para la página.
    final structureIdResult = StructureId.validate(params.structureId);
    final notebookIdResult = StructureNotebookReference.validate(params.notebookId);
    final parentIdResult = StructureParentId.validate(params.parentId);
    final typeResult = StructureElementType.validate(params.type);
    final elementResult = StructureElementReference.forPage(params.pageId);
    final positionResult = StructurePosition.validate(params.position);
    final depthResult = StructureDepth.validatePage(params.depth);

    // Acumular errores.
    if (structureIdResult.isFailure) failures.addAll(structureIdResult.getFailure());
    if (notebookIdResult.isFailure) failures.addAll(notebookIdResult.getFailure());
    if (parentIdResult.isFailure) failures.addAll(parentIdResult.getFailure());
    if (typeResult.isFailure) failures.addAll(typeResult.getFailure());
    if (elementResult.isFailure) failures.addAll(elementResult.getFailure());
    if (positionResult.isFailure) failures.addAll(positionResult.getFailure());
    if (depthResult.isFailure) failures.addAll(depthResult.getFailure());

    if (failures.isNotEmpty) return Result.failure(failures);

    return Result.success(Structure._(
      id: structureIdResult.getSuccess(),
      notebookId: notebookIdResult.getSuccess(),
      parentId: parentIdResult.getSuccess(),
      elementId: elementResult.getSuccess(),
      type: typeResult.getSuccess(),
      position: positionResult.getSuccess(),
      depth: depthResult.getSuccess(),
    ));
  }
}



/// NotebookStructureParams: Clase que representa los parámetros necesarios para crear un `NotebookStructure`.
class StructureParams {
  const StructureParams({
    this.structureId, 
    this.parentId, 
    this.notebookId, 
    this.type,
    this.folderId, 
    this.pageId, 
    this.position, 
    this.depth,
  });
  
  final String? structureId;
  final String? parentId;
  final String? notebookId;
  final String? type;
  final String? folderId;
  final String? pageId;
  final int? position;
  final int? depth;
}
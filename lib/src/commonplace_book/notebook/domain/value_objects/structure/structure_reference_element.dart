// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// StructureElementReference: Objeto de valor que valida que folderId y pageId sean validos.
/// - Solo puede existir un valor válido, mietras que el otro será null. (No es posible tener una carpeta y página al mismo tiempo ni que ambos sean nulos).
class StructureElementReference {
  const StructureElementReference._({
    this.folderId, 
    this.pageId
  });
  
  final String? folderId;
  final String? pageId;
  
  bool get isFolder => folderId != null && pageId == null;
  bool get isPage => pageId != null && folderId == null;
  
  /// ForFolder: Crea una referencia a una carpeta válida.
  static Result<StructureElementReference, List<DomainFailure>> forFolder(String? folderId) {
    return _validate(folderId: folderId, pageId: null);
  }
  
  /// ForPage: Crea una referencia a una página válida.
  static Result<StructureElementReference, List<DomainFailure>> forPage(String? pageId) {
    return _validate(folderId: null, pageId: pageId);
  }
  

  /// Validate: Método de validación que garantiza la integridad del dominio.
  static Result<StructureElementReference, List<DomainFailure>> _validate({String? folderId, String? pageId}) {
    final failures = <DomainFailure>[];
    
    // Caso 1: Ambos IDs son nulos.
    if(folderId == null && pageId == null) {
      failures.add(StructureInconsistentContentReferenceFailure(
        details: 'Either folderId or pageId must be provided, but both are null.'
      ));
      return Result.failure(failures);
    }
    
    // Caso 2: Ambos IDs están presentes.
    if(folderId != null && pageId != null) {
      failures.add(StructureInconsistentContentReferenceFailure(
        details: 'Only one of folderId or pageId must be provided, but both are presente.'
      ));
      return Result.failure(failures);
    }
    
    // Caso 3: folderId presente pero vacío - error específico.
    if (folderId != null && folderId.trim().isEmpty) {
      failures.add(StructureFolderIdReferenceFailure(
        details: 'FolderId cannot be empty.'
      ));
      return Result.failure(failures);
    }
    
    // Caso 4: pageId presente pero vacío - error específico.
    if (pageId != null && pageId.trim().isEmpty) {
      failures.add(StructurePageIdReferenceFailure(
        details: 'PageId cannot be empty.'
      ));
      return Result.failure(failures);
    }
    
    return Result.success(StructureElementReference._(
      folderId: folderId,
      pageId: pageId
    ));
  }
}
// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de Id ----- //
class StructureInvalidIdFailure extends DomainFailure {
  StructureInvalidIdFailure({super.details}) : super(
    code: StructureErrorCode.invalidStructureId,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidStructureId),
  );
}

class StructureNotebookIdReferenceFailure extends DomainFailure {
  StructureNotebookIdReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidNotebookIdReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidNotebookIdReference),
  );
}

class StructureInvalidParentIdFailure extends DomainFailure {
  StructureInvalidParentIdFailure({super.details}) : super(
    code: StructureErrorCode.invalidParentId,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidParentId),
  );
}

class StructureInvalidTypeFailure extends DomainFailure {
  StructureInvalidTypeFailure({super.details}) : super(
    code: StructureErrorCode.invalidStructureType,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidStructureType)
  );
}

class StructureFolderIdReferenceFailure extends DomainFailure {
  StructureFolderIdReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidFolderIdReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidFolderIdReference)
  );
}

class StructurePageIdReferenceFailure extends DomainFailure {
  StructurePageIdReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidPageIdReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidPageIdReference)
  );
}



// ----- Errores de Estructura ----- //
class StructureInconsistentContentReferenceFailure extends DomainFailure {
  StructureInconsistentContentReferenceFailure({super.details}) : super(
    code: StructureErrorCode.inconsistentContentReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.inconsistentContentReference)
  );
}

class StructureParentCannotBePageFailure extends DomainFailure {
  StructureParentCannotBePageFailure({super.details}) : super(
    code: StructureErrorCode.parentCannotBePage,
    message: StructureErrorMessages.getMessage(StructureErrorCode.parentCannotBePage)
  );
}

class StructureInvalidPositionFailure extends DomainFailure {
  StructureInvalidPositionFailure({super.details}) : super(
    code: StructureErrorCode.invalidPosition,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidPosition)
  );
}

class StructureInvalidDepthFailure extends DomainFailure {
  StructureInvalidDepthFailure({super.details}) : super(
    code: StructureErrorCode.invalidDepth,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidDepth)
  );
}

class StructureInconsistentHierarchyFailure extends DomainFailure {
  StructureInconsistentHierarchyFailure({super.details}) : super(
    code: StructureErrorCode.inconsistentHierarchy,
    message: StructureErrorMessages.getMessage(StructureErrorCode.inconsistentHierarchy
    )
  );
}
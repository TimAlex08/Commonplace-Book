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

class StructureInvalidParentIdFailure extends DomainFailure {
  StructureInvalidParentIdFailure({super.details}) : super(
    code: StructureErrorCode.invalidParentId,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidParentId),
  );
}

class StructureNotebookReferenceFailure extends DomainFailure {
  StructureNotebookReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidNotebookReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidNotebookReference),
  );
}

class StructureFolderReferenceFailure extends DomainFailure {
  StructureFolderReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidFolderReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidFolderReference)
  );
}

class StructurePageReferenceFailure extends DomainFailure {
  StructurePageReferenceFailure({super.details}) : super(
    code: StructureErrorCode.invalidPageReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.invalidPageReference)
  );
}



// ----- Errores de Estructura ----- //
class StructureMissingContentReferenceFailure extends DomainFailure {
  StructureMissingContentReferenceFailure({super.details}) : super(
    code: StructureErrorCode.missingContentReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.missingContentReference)
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
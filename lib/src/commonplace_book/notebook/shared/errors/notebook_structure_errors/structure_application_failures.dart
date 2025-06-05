// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



class StructureNotebookNotFoundFailure extends ApplicationFailure {
  StructureNotebookNotFoundFailure({super.details}) : super(
    code: StructureErrorCode.notebookIdNotFound,
    message: StructureErrorMessages.getMessage(StructureErrorCode.notebookIdNotFound)
  );
}

class StructureNotFoundFailure extends ApplicationFailure {
  StructureNotFoundFailure({super.details}) : super(
    code: StructureErrorCode.structureIdNotFound,
    message: StructureErrorMessages.getMessage(StructureErrorCode.structureIdNotFound)
  );
}

class StructureDoesNotBelongToNotebookFailure extends ApplicationFailure {
  StructureDoesNotBelongToNotebookFailure({super.details}) : super(
    code: StructureErrorCode.structureDoesNotBelongToNotebook,
    message: StructureErrorMessages.getMessage(StructureErrorCode.structureDoesNotBelongToNotebook)
  );
}

class StructureCircularReferenceFailure extends ApplicationFailure {
  StructureCircularReferenceFailure({super.details}) : super(
    code: StructureErrorCode.circularReference,
    message: StructureErrorMessages.getMessage(StructureErrorCode.circularReference)
  );
}

class StructureReorderFailure extends ApplicationFailure {
  StructureReorderFailure({super.details}) : super(
    code: StructureErrorCode.structureReorderFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.structureReorderFailed),
  );
}

class StructureMoveFailure extends ApplicationFailure {
  StructureMoveFailure({super.details}) : super(
    code: StructureErrorCode.structureMovedFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.structureMovedFailed),
  );
}
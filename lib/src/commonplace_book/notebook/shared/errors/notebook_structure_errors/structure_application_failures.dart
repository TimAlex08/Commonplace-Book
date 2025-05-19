// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



class StructureNotebookNotFoundFailure extends ApplicationFailure {
  StructureNotebookNotFoundFailure({super.details}) : super(
    code: StructureErrorCode.notebookNotFound,
    message: StructureErrorMessages.getMessage(StructureErrorCode.notebookNotFound)
  );
}

class StructureAlreadyExistsFailure extends ApplicationFailure {
  StructureAlreadyExistsFailure({super.details}) : super(
    code: StructureErrorCode.structureAlreadyExists,
    message: StructureErrorMessages.getMessage(StructureErrorCode.structureAlreadyExists)
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

class StructureNodeAlreadyExistsFailure extends ApplicationFailure {
  StructureNodeAlreadyExistsFailure({super.details}) : super(
    code: StructureErrorCode.nodeAlreadyExists,
    message: StructureErrorMessages.getMessage(StructureErrorCode.nodeAlreadyExists)
  );
}
// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de ID ----- //
class FolderInvalidIdFailure extends DomainFailure {
  FolderInvalidIdFailure({super.details}) : super(
    code: FolderErrorCode.invalidId,
    message: FolderErrorMessages.getMessage(FolderErrorCode.invalidId)
  );
}



// ----- Errores de Nombre ----- //
class FolderInvalidNameFailure extends DomainFailure {
  FolderInvalidNameFailure({super.details}) : super(
    code: FolderErrorCode.invalidName,
    message: FolderErrorMessages.getMessage(FolderErrorCode.invalidName)
  );
}

class FolderNameTooLongFailure extends DomainFailure {
  FolderNameTooLongFailure({super.details}) : super(
    code: FolderErrorCode.nameTooLong,
    message: FolderErrorMessages.getMessage(FolderErrorCode.nameTooLong)
  );
}
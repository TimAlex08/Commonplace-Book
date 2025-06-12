// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



class FolderNotFoundFailure extends ApplicationFailure {
  FolderNotFoundFailure({super.details}) : super(
    code: FolderErrorCode.folderNotFound,
    message: FolderErrorMessages.getMessage(FolderErrorCode.folderNotFound)
  );
}
// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';


// ----- Errores de Conexion ----- //
class FolderDBConnectionFailure extends InfrastructureFailure {
  FolderDBConnectionFailure({super.details}) : super(
    code: FolderErrorCode.dbConnectionFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.dbConnectionFailed),
  );
}

class FolderDBInitializationFailure extends InfrastructureFailure {
  FolderDBInitializationFailure({super.details}) : super(
    code: FolderErrorCode.dbInitializationFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.dbInitializationFailed),
  );
}



// ----- Errores CRUD ----- //
class FolderInsertFailure extends InfrastructureFailure {
  FolderInsertFailure({super.details}) : super(
    code: FolderErrorCode.insertFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.insertFailed),
  );
}

class FolderUpdateFailure extends InfrastructureFailure {
  FolderUpdateFailure({super.details}) : super(
    code: FolderErrorCode.updateFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.updateFailed),
  );
}

class FolderDeleteFailure extends InfrastructureFailure {
  FolderDeleteFailure({super.details}) : super(
    code: FolderErrorCode.deleteFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.deleteFailed),
  );
}

class FolderReadFailure extends InfrastructureFailure {
  FolderReadFailure({super.details}) : super(
    code: FolderErrorCode.readFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.readFailed),
  );
}

class FolderQueryFailure extends InfrastructureFailure {
  FolderQueryFailure({super.details}) : super(
    code: FolderErrorCode.queryFailed,
    message: FolderErrorMessages.getMessage(FolderErrorCode.queryFailed),
  );
}
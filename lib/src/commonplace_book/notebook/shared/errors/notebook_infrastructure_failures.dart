// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_error_codes.dart';

/// ----- Errores de Conexión ----- ///
class NotebookDBConnectionFailure extends InfrastructureFailure {
  NotebookDBConnectionFailure({super.details}) : super(
    code : NotebookErrorCode.dbConnectionFailded,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.dbConnectionFailded),
  );
}

class NotebookDbInitializationFailure extends InfrastructureFailure {
  NotebookDbInitializationFailure({super.details}) : super(
    code: NotebookErrorCode.dbInitializationFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.dbInitializationFailed),
  );
}



/// ----- Errores CRUD ----- ///
class NotebookInsertFailure extends InfrastructureFailure {
  NotebookInsertFailure({super.details}) : super(
    code: NotebookErrorCode.insertFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.insertFailed),
  );
}

class NotebookUpdateFailure extends InfrastructureFailure {
  NotebookUpdateFailure({super.details}) : super(
    code: NotebookErrorCode.updateFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.updateFailed),
  );
}

class NotebookDeleteFailure extends InfrastructureFailure {
  NotebookDeleteFailure({super.details}) : super(
    code: NotebookErrorCode.deleteFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.deleteFailed),
  );
}

class NotebookReadFailure extends InfrastructureFailure {
  NotebookReadFailure({super.details}) : super(
    code: NotebookErrorCode.readFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.readFailed),
  );
}

class NotebookQueryFailure extends InfrastructureFailure {
  NotebookQueryFailure({super.details}) : super(
    code: NotebookErrorCode.queryFailed,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.queryFailed),
  );
}
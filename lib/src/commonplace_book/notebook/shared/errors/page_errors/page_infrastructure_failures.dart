// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_error_codes.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de Conexión ----- //
class PageDBConnectionFailure extends InfrastructureFailure {
  PageDBConnectionFailure({super.details}) : super(
    code: PageErrorCode.dbConnectionFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.dbConnectionFailed),
  );
}

class PageDBInitializationFailure extends InfrastructureFailure {
  PageDBInitializationFailure({super.details}) : super(
    code: PageErrorCode.dbInitializationFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.dbInitializationFailed),
  );
}



// ----- Errores CRUD ----- //
class PageInsertFailure extends InfrastructureFailure {
  PageInsertFailure({super.details}) : super(
    code: PageErrorCode.insertFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.insertFailed),
  );
}

class PageUpdateFailure extends InfrastructureFailure {
  PageUpdateFailure({super.details}) : super(
    code: PageErrorCode.updateFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.updateFailed),
  );
}

class PageDeleteFailure extends InfrastructureFailure {
  PageDeleteFailure({super.details}) : super(
    code: PageErrorCode.deleteFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.deleteFailed),
  );
}

class PageReadFailure extends InfrastructureFailure {
  PageReadFailure({super.details}) : super(
    code: PageErrorCode.readFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.readFailed),
  );
}

class PageQueryFailure extends InfrastructureFailure {
  PageQueryFailure({super.details}) : super(
    code: PageErrorCode.queryFailed,
    message: PageErrorMessages.getMessage(PageErrorCode.queryFailed),
  );
}
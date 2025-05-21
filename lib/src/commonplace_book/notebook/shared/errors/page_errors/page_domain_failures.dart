// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_error_codes.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de ID ----- //
class PageInvalidIdFailure extends DomainFailure {
  PageInvalidIdFailure({super.details}) : super(
    code: PageErrorCode.invalidId,
    message: PageErrorMessages.getMessage(PageErrorCode.invalidId),
  );
}



// ----- Errores de Título ----- //
class PageInvalidTitleFailure extends DomainFailure {
  PageInvalidTitleFailure({super.details}) : super(
    code: PageErrorCode.invalidTitle,
    message: PageErrorMessages.getMessage(PageErrorCode.invalidTitle),
  );
}

class PageTitleTooLongFailure extends DomainFailure {
  PageTitleTooLongFailure({super.details}) : super(
    code: PageErrorCode.titleTooLong,
    message: PageErrorMessages.getMessage(PageErrorCode.titleTooLong)
  );
}



// ----- Errores de Fechas ----- //
class PageInvalidCreatedAtFailure extends DomainFailure {
  PageInvalidCreatedAtFailure({super.details}) : super(
    code: PageErrorCode.invalidCreatedAt,
    message: PageErrorMessages.getMessage(PageErrorCode.invalidCreatedAt),
  );
}

class PageInvalidUpdatedAtFailure extends DomainFailure {
  PageInvalidUpdatedAtFailure({super.details}) : super(
    code: PageErrorCode.invalidUpdatedAt,
    message: PageErrorMessages.getMessage(PageErrorCode.invalidUpdatedAt),
  );
}

class PageUpdatedBeforeCreatedFailure extends DomainFailure {
  PageUpdatedBeforeCreatedFailure({super.details}) : super(
    code: PageErrorCode.updatedBeforeCreated,
    message: PageErrorMessages.getMessage(PageErrorCode.updatedBeforeCreated),
  );
}
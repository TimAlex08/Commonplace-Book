// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_error_codes.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de Aplicación ----- //
class PageNotFoundFailure extends ApplicationFailure {
  PageNotFoundFailure({super.details}) : super(
    code: PageErrorCode.pageNotFound,
    message: PageErrorMessages.getMessage(PageErrorCode.pageNotFound)
  );
}
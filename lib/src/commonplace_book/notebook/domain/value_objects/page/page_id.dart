// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



/// PageId: Objeto de valor que valida que el ID de la página sea correcto.
class PageId {
  const PageId._(this.value);
  final String value;
  
  static Result<PageId, List<DomainFailure>> validate(String? id) {
    final failures = <DomainFailure>[];
    
    // Valida que el ID no sea nulo
    if(id == null) {
      failures.add(PageInvalidIdFailure(
        details: 'ID cannot be null'
      ));
      return Result.failure(failures);
    }
    
    final trimmedId = id.trim();
    
    // Valida que el ID no sea vacío
    if(trimmedId.isEmpty) {
      failures.add(PageInvalidIdFailure(
        details: 'ID cannot be empty'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el ID de la libreta como un éxito
    return Result.success(PageId._(id));
  }
}
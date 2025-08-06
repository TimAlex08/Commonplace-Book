// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// PageTimestamp: Objeto de valor que representa las fechas de creación y actualización de un `Page`.
/// - Valida que las fechas no sean nulas y que la fecha de creación no sea posterior a la de actualización.
class PageTimestamp {
  const PageTimestamp._({
    required this.createdAt, 
    required this.updatedAt
  });
  
  final DateTime createdAt;
  final DateTime updatedAt;
  
  /// Valida los valores `PageTimestampt` (`CreatedAt `y `UpdatedAt`).
  static Result<PageTimestamp, List<DomainFailure>> validate({DateTime? createdAt, DateTime? updatedAt}) {
    final failures = <DomainFailure>[];
    
    // Valida que la fecha de creación no sea nula.
    if(createdAt == null) {
      failures.add(PageInvalidCreatedAtFailure(
        details: 'Created date cannot be null.'
      ));
    }
    
    // Valida que la fecha de actualización no sea nula.
    if(updatedAt == null) {
      failures.add(PageInvalidUpdatedAtFailure(
        details: 'Updated date cannot be null.'
      ));
    }
    
    // Si alguna fecha es nula, no podemos hacer más validaciones.
    if (failures.isNotEmpty) return Result.failure(failures);

    // Valida que la fecha de creación no sea posterior a la fecha de actualización.
    if(updatedAt!.isBefore(createdAt!)) {
      failures.add(PageUpdatedBeforeCreatedFailure(
        details: 'Created date: $createdAt, Updated date: $updatedAt'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el objeto PageTimestamp de la página como un éxito.
    return Result.success(PageTimestamp._(
        createdAt: createdAt,
        updatedAt:  updatedAt
      )
    );
  }
}
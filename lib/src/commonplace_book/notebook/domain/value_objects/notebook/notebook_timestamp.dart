// Failures / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// NotebookTimestamp: Objeto de valor que representa las fechas de creación y actualización de un `Notebook`.
/// - Valida que las fechas no sean nulas y que la fecha de creación no sea posterior a la de actualización.
class NotebookTimestamp {
  const NotebookTimestamp._({
    required this.createdAt, 
    required this.updatedAt
  });
  
  final DateTime createdAt;
  final DateTime updatedAt;
  
  /// Valida los valores `NotebookTimestampt` (`CreatedAt `y `UpdatedAt`).
  static Result<NotebookTimestamp, List<DomainFailure>> validate({DateTime? createdAt, DateTime? updatedAt}) {
    final failures = <DomainFailure>[];
    
    // Valida que la fecha de creación no sea nula.
    if(createdAt == null) {
      failures.add(NotebookInvalidCreatedAtFailure(
        details: 'Created date cannot be null.'
      ));
    }
    
    // Valida que la fecha de actualización no sea nula.
    if(updatedAt == null) {
      failures.add(NotebookInvalidUpdatedAtFailure(
        details: 'Updated date cannot be null.'
      ));
    }
    
    // Si alguna fecha es nula, no podemos hacer más validaciones.
    if (failures.isNotEmpty) return Result.failure(failures);
    
    // Valida que la fecha de creación no sea posterior a la fecha de actualización.
    if(updatedAt!.isBefore(createdAt!)) {
      failures.add(NotebookUpdatedBeforeCreatedFailure(
        details: 'Created date: $createdAt, Updated date: $updatedAt.'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el objeto NotebookTimestamp de la libreta como un éxito.
    return Result.success(NotebookTimestamp._(
        createdAt: createdAt,
        updatedAt:  updatedAt
      )
    );
  }
}
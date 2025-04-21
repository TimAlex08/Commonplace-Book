// Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';



/// NotebookTimestamp: Objeto de valor que representa las fechas de creación y actualización de un `Notebook`.
/// - Valida que las fechas no sean nulas yque la fecha de creacion no sea posterior a la de actaualización
class NotebookTimestamp {
  const NotebookTimestamp._(this.createdAt, this.updatedAt);
  
  final DateTime createdAt;
  final DateTime updatedAt;
  
  /// Crea un nuevo `NotebookTimestamp` (`createdAt` y `updatedAt`) válido con la fecha y hora actual.
  /// - Si ocurre un error durante la creación, se retorna un `Result.failure` con una lista de errores.
  static Result<NotebookTimestamp, List<DomainFailure>> createValidTimestamp() {
    final dateTimeNow = DateTime.now();
    return validate(dateTimeNow, dateTimeNow);
  }
  
  /// Valida los valores `NotebookTimestampt` (`CreatedAt `y `UpdatedAt`).
  static Result<NotebookTimestamp, List<DomainFailure>> validate(DateTime? createdAt, DateTime? updatedAt) {
    final failures = <DomainFailure>[];
    
    // Valida que la fecha de creación no sea nula
    if(createdAt == null) {
      failures.add(NotebookInvalidCreatedAtFailure(
        details: 'Created date cannot be null'
      ));
    }
    
    // Valida que la fecha de actualización no sea nula
    if(updatedAt == null) {
      failures.add(NotebookInvalidUpdatedAtFailure(
        details: 'Updated date cannot be null'
      ));
    }
    
    // Valida que ni la fecha de creación ni la de actualización sean nulas
    // si es así entonces retorna un `Result.failure` con la lista de errores
    if(createdAt == null || updatedAt == null) {
      return Result.failure(failures);
    }
    
    // Valida que la fecha de creación no sea posterior a la fecha de actualización
    if(updatedAt.isBefore(createdAt)) {
      failures.add(NotebookUpdatedBeforeCreatedFailure(
        details: 'Created date: $createdAt, Updated date: $updatedAt'
      ));
    }
    
    // Si hay errores retoramos un `Result.failure` con la lista de errores
    if(failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    return Result.success(NotebookTimestamp._(createdAt, updatedAt,));
  }
}
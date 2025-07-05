// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// NotebookId: Objeto de valor que valida que el ID de la libreta sea correcto.
class NotebookId {
  const NotebookId._(this.value);
  final String value;
  
  static Result<NotebookId, List<DomainFailure>> validate(String? id) {
    final failures = <DomainFailure>[];
    
    // Valida que el ID no sea nulo.
    if(id == null) {
      failures.add(NotebookInvalidIdFailure(
        details: 'ID cannot be null.'
      ));
      return Result.failure(failures);
    }
    
    final trimmedId = id.trim();
    
    // Valida que el ID no sea vacío
    if(trimmedId.isEmpty) {
      failures.add(NotebookInvalidIdFailure(
        details: 'ID cannot be empty.'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el ID de la libreta como un éxito.
    return Result.success(NotebookId._(id));
  }
}
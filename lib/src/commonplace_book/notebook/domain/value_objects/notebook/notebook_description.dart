// Constants
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



/// NotebookDescription: Objeto de valor que representa la descripción de un `Notebook`.
/// - Valida que la descripción no exceda la longitud máxima permitida.
class NotebookDescription {
  const NotebookDescription._(this.value);
  
  final String value;  
  
  /// Método que valida `NotebookDescription`
  static Result<NotebookDescription, List<DomainFailure>> validate(String? description) {
    final failures = <DomainFailure>[];
    
    // Corta los espacios en blanco al principio y al final de la cadena de entrada y si es nulo le asigna una cadena vacía.
    final trimmedDescription = description?.trim() ?? '';
    
    // Valida que la descripción no exceda la longitud máxima
    if(trimmedDescription.length > NotebookConstants.maxNotebookDescriptionLength) {
      failures.add(NotebookDescriptionTooLongFailure(
        details: 'Actual Length: ${trimmedDescription.length}, Max Length: ${NotebookConstants.maxNotebookDescriptionLength}',
      ));
    }
    
    // Si hay errores, devuelve una lista de fallos
    if (failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve la descripción de la libreta como un éxito
    return Result.success(NotebookDescription._(trimmedDescription));
  }
}
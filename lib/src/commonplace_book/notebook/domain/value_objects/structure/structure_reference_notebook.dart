// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// StructureFolderReference: Objeto de valor que valida que el ID de referencia de la carpeta sea correcto.
class StructureNotebookReference {
  const StructureNotebookReference._(this.value);
  final String value;
  
  static Result<StructureNotebookReference, List<DomainFailure>> validate(String? id) {
    final failures = <DomainFailure>[];
    
    // Valida que el ID no sea nulo.
    if(id == null) {
      failures.add(StructureNotebookIdReferenceFailure(
        details: 'Notebook ID reference cannot be null.'
      ));
      return Result.failure(failures);
    }
    
    // Remueve espacios en blanco al inicio y al final.
    final trimmedId = id.trim();
    
    if(trimmedId.isEmpty) {
      failures.add(StructureNotebookIdReferenceFailure(
        details: 'Notebook ID reference cannot be empty.'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el ID de la libreta como un éxito.
    return Result.success(StructureNotebookReference._(trimmedId));
  }
}
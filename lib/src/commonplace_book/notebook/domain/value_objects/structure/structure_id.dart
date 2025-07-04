// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// StructureId: Objeto de valor que valida que el ID de la estructura sea correcto.
class StructureId {
  const StructureId._(this.value);
  final String value;
  
  static Result<StructureId, List<DomainFailure>> validate(String? id) {
    final failures = <DomainFailure>[];
    
    // Valida que el ID no sea nulo.
    if(id == null) {
      failures.add(StructureInvalidIdFailure(
        details: 'ID cannot be null.'
      ));
      return Result.failure(failures);
    }
    
    // Remueve espacios en blanco al inicio y al final.
    final trimmedId = id.trim();
    
    if(trimmedId.isEmpty) {
      failures.add(StructureInvalidIdFailure(
        details: 'ID cannot be empty.'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el ID de la libreta como un éxito.
    return Result.success(StructureId._(id));
  }
}
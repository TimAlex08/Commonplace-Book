// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// StructurePosition: Objeto de valor que válida que la posición de un elemento sea valida.
/// - Valida que no sea nulo ni menor a 0.
class StructurePosition {
  const StructurePosition._(this.value);
  final int value;
  
  static Result<StructurePosition, List<DomainFailure>> validate(int? position) {
    final failures = <DomainFailure>[];
    
    if(position == null) {
      failures.add(StructureInvalidPositionFailure(
        details: 'Position cannot be null.'
      ));
      return Result.failure(failures);
    }
    
    if(position < 0) {
      failures.add(StructureInvalidPositionFailure(
        details:  'Position must be >= 0.'
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve una posición válida
    return Result.success(StructurePosition._(position));
  }
}
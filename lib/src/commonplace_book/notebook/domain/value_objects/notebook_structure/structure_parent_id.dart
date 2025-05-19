// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



class StructureParentId {
  const StructureParentId._(this.value);
  
  final String? value; // Ahora puede ser null

  static Result<StructureParentId, List<DomainFailure>> validate({String? id, bool isFolder = false}) {
    final failures = <DomainFailure>[];
    
    final trimmed = id?.trim();
    
    // Si es null o vacío, lo interpretamos como raíz válida
    if (trimmed == null || trimmed.isEmpty) {
      return Result.success(StructureParentId._(null));
    }

    // Verificar que el elemento referenciado sea una carpeta
    if(isFolder == false) {
      failures.add(StructureInvalidParentIdFailure(
        details: 'Page cannot be parent'
      ));
    }
    
    // Si hay reglas para IDs válidos, se colocan aquí
    return Result.success(StructureParentId._(trimmed));
  }
}
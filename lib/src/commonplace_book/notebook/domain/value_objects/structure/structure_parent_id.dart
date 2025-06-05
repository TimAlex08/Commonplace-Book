// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



class StructureParentId {
  const StructureParentId._(this.value);
  
  final String? value; // Ahora puede ser null

  static Result<StructureParentId, List<DomainFailure>> validate(String? id) {
    final trimmed = id?.trim();
    
    // Si es null o vacío, lo interpretamos como raíz válida
    if (trimmed == null || trimmed.isEmpty) {
      return Result.success(StructureParentId._(null));
    }

    // Si hay reglas para IDs válidos, se colocan aquí
    return Result.success(StructureParentId._(trimmed));
  }
}
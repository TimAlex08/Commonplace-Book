// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';

// Value Objects
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/folder/folder_vo.dart';



/// Folder: Representa la entidad de una carpeta dentro de una libreta en la aplicación.
class Folder {
  const Folder._({
    required this.id,
    required this.name,
  });
  
  final FolderId id;
  final FolderName name;
  
  static Result<Folder, List<DomainFailure>> create(FolderParams params) {
    final failures = <DomainFailure>[];
    
    // ----- Validaciones de parámetros ----- //
    final idResult = FolderId.validate(params.id);
    final nameResult = FolderName.validate(params.id);
    
    // ----- Acumular errores si hay fallos en la validaciones ----- //
    if (idResult.isFailure) failures.addAll(idResult.getFailure());
    if (nameResult.isFailure) failures.addAll(nameResult.getFailure());
    
    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) return Result.failure(failures);
    
    // Si no hay errores, crea un objeto válido Folder.
    return Result.success(Folder._(
      id: idResult.getSuccess(), 
      name: nameResult.getSuccess()
    ));
  }
}



/// FolderParams: Clase que representa los parámetros necesarios para crear un `Folder`.
class FolderParams {
  const FolderParams({
    this.id,
    this.name,
  });
  
  final String? id;
  final String? name;
}
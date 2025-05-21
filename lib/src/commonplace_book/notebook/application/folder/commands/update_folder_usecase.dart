// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class UpdateFolderUseCase {
  const UpdateFolderUseCase(this._repository);
  final ForPersistingFoldersPort _repository;
  
  Future<Result<int, List<Failure>>> execute(FolderDTO dto) async {
    // Genera los FolderParams a partir del DTO completo
    final folder = FolderDomainMapper.toParams(dto);
    
    // TODO: Validar con NotebookStructure
    /// El método `create` de la clase `Folder` recibe un objeto `FolderParams` y devuelve un
    /// `Result<Folder, List<DomainFailure>>` que contiene el objeto `Folder` o una lista de fallos.
    final validateFolderResult = Folder.create(folder);
    
    if(validateFolderResult.isFailure) {
      final failures = validateFolderResult.getFailure();
      return Result.failure(failures);
    }
    
    // Si el notebook es válido, proceder con la creación
    final validFolder = validateFolderResult.getSuccess();
    final result = await _repository.commands.updateFolder(validFolder);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
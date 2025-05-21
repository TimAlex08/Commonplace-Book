// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class GetFolderByIdUsecase {
  const GetFolderByIdUsecase(this._repository);
  final ForPersistingFoldersPort _repository;
  
  Future<Result<FolderDTO, List<Failure>>> execute(String folderId) async {
    /// Obtiene un notebook por su ID de la base de datos.
    final result = await _repository.queries.getFolderById(folderId);
    
    return result.fold(
      (folder) => Result.success(folder!),
      (failures) => Result.failure([failures]),
    );
  }
}
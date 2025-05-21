// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class GetAllFoldersUsecase {
  const GetAllFoldersUsecase(this._repository);
  final ForPersistingFoldersPort _repository;
  
  Future<Result<List<FolderDTO>, List<Failure>>> execute() async {
    /// Obtiene todos los notebooks de la base de datos.
    final result = await _repository.queries.getAllFolders();
    
    return result.fold(
      (folders) => Result.success(folders ?? []),
      (failures) => Result.failure([failures]),
    );
  }
}
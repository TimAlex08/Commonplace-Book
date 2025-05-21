// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class HardDeleteFolderUsecase {
  const HardDeleteFolderUsecase(this._repository);
  final ForPersistingFoldersPort _repository;
  
  Future<Result<int, List<Failure>>> execute(String folderId) async {
    // Ejecuta el comando de eliminación dura en el repositorio
    final result = await _repository.commands.hardDeleteFolder(folderId);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
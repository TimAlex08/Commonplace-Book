// Failure / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_folders_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



/// FolderManagerAdapter: Adaptador para la gestión de `Folder` en la aplicación.
class FolderManagerAdapter {
  const FolderManagerAdapter(this._port);
  final ForManagingFoldersPort _port;
  
  // ----- Comandos ----- //
  Future<Result<int, List<Failure>>> updateFolderTitle({required String folderId, required newTitle}) async {
    final dto = FolderDTO(id: folderId, name: newTitle);
    final result = await _port.command.updateFolderTitle(dto);
    
    return result.fold(
      (row) =>  Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      });
  }
}
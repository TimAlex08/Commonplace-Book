// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class WatchFolderByIdUsecase {
  const WatchFolderByIdUsecase(this._repository);
  final ForPersistingFoldersPort _repository;
  
  Stream<FolderDTO> execute(String folderId) {
    return _repository.observers.watchFolderById(folderId);
  }
}
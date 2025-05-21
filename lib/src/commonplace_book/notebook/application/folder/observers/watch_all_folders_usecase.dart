// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';



class WatchAllFoldersUsecase {
  const WatchAllFoldersUsecase(this._repository);
  final ForPersistingFoldersPort _repository;
  
    Stream<List<FolderDTO>> execute() {
    return _repository.observers.watchAllFolders();
  }
}
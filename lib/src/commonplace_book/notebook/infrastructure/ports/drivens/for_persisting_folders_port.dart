// Folder Entity
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';

// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



abstract class ForPersistingFoldersPort {
  FolderPersistenceCommands get commands;
  FolderPersistenceQueries get queries;
  FolderPersistenceObservers get observers;
}

abstract class FolderPersistenceCommands {
  Future<Result<int, Failure>> createFolder(Folder folder);
  Future<Result<int, Failure>> updateFolder(Folder folder);
  Future<Result<int, Failure>> hardDeleteFolder(String id);
}

abstract class FolderPersistenceQueries {
  Future<Result<List<FolderDTO>?, Failure>> getAllFolders();
  Future<Result<FolderDTO?, Failure>> getFolderById(String id);
}

abstract class FolderPersistenceObservers {
  Stream<List<FolderDTO>> watchAllFolders();
  Stream<FolderDTO> watchFolderById(String id);
}

// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';



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

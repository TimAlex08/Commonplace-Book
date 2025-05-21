// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';



abstract class ForManagingFoldersPort {
  FolderManagementCommands get command;
  FolderManagementQueries get query;
  FolderManagementObservers get observer;
}

abstract class FolderManagementCommands {
  Future<Result<int, List<Failure>>> createFolder(FolderDTO folder);
  Future<Result<int, List<Failure>>> updateFolder(FolderDTO folder);
  Future<Result<int, List<Failure>>> hardDeleteFolder(String id);
}

abstract class FolderManagementQueries {
  Future<Result<List<FolderDTO>, List<Failure>>> getAllFolders();
  Future<Result<FolderDTO, List<Failure>>> getFolderById(String id);
}

abstract class FolderManagementObservers {
  Stream<List<FolderDTO>> watchAllFolders();
  Stream<FolderDTO> watchFolderById(String id);
}
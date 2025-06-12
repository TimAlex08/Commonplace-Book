// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';



abstract class ForManagingFoldersPort {
  FolderManagementCommands get command;
}

abstract class FolderManagementCommands {
  Future<Result<int, List<Failure>>> updateFolderTitle(FolderDTO dto);
}

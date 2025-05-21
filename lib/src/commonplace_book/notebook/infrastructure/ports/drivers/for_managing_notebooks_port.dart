// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';



abstract class ForManagingNotebooksPort{
  NotebookManagementCommands get command;
  NotebookManagementQueries get query;
  NotebookManagementObservers get observer;
}

abstract class NotebookManagementCommands {
  Future<Result<int, List<Failure>>> createNotebook(NotebookDTO notebook);
  Future<Result<int, List<Failure>>> updateNotebook(NotebookDTO notebook);
  Future<Result<int, List<Failure>>> hardDeleteNotebook(String id);
}

abstract class NotebookManagementQueries {
  Future<Result<List<NotebookDTO>, List<Failure>>> getAllNotebooks();
  Future<Result<NotebookDTO, List<Failure>>> getNotebookById(String id);
}

abstract class NotebookManagementObservers {
  Stream<List<NotebookDTO>> watchAllNotebooks();
  Stream<NotebookDTO> watchNotebookById(String id);
}
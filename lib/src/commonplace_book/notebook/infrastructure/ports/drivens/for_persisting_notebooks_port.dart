// Failures / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';



abstract class ForPersistingNotebooksPort {
  NotebookPersistenceCommands get commands;
  NotebookPersistenceQueries get queries;
  NotebookPersistenceObservers get observers;
}

abstract class NotebookPersistenceCommands {
  Future<Result<int, Failure>> createNotebook(Notebook notebook);
  Future<Result<int, Failure>> updateNotebook(Notebook notebook);
  Future<Result<int, Failure>> hardDeleteNotebook(String notebookId);
}

abstract class NotebookPersistenceQueries {
  Future<Result<List<NotebookDTO>?, Failure>> getAllNotebooks();
  Future<Result<NotebookDTO?, Failure>> getNotebookById(String notebookId);
}

abstract class NotebookPersistenceObservers {
  Stream<List<NotebookDTO>> watchAllNotebooks();
  Stream<NotebookDTO> watchNotebookById(String notebookId);
}
// Notebook Entity
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';

// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';



abstract class ForPersitingNotebooksPort {
  NotebookPersistenceCommands get commands;
  NotebookPersistenceQueries get queries;
  NotebookPersistenceObservers get observers;
}

abstract class NotebookPersistenceCommands {
  Future<Result<int, Failure>> createNotebook(Notebook notebook);
  Future<Result<int, Failure>> updateNotebook(Notebook notebook);
  Future<Result<int, Failure>> hardDeleteNotebook(String id);
}

abstract class NotebookPersistenceQueries {
  Future<Result<List<NotebookDTO>?, Failure>> getAllNotebooks();
  Future<Result<NotebookDTO?, Failure>> getNotebookById(String id);
}

abstract class NotebookPersistenceObservers {
  Stream<List<NotebookDTO>> watchAllNotebooks();
  Stream<NotebookDTO> watchNotebookById(String id);
}
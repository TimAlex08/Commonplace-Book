// Notebook Entity
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';



abstract class ForPersitingNotebooksPort {
  NotebookPersistenceCommands get commands;
  NotebookPersistenceQueries get queries;
  NotebookPersistenceObservers get observers;
}

abstract class NotebookPersistenceCommands {
  Future<int> createNotebook(Notebook notebook);
  Future<int> updateNotebook(Notebook notebook);
  Future<int> hardDeleteNotebook(String id);
}

abstract class NotebookPersistenceQueries {
  Future<List<NotebookDTO>> getAllNotebooks();
  Future<NotebookDTO?> getNotebookById(String id);
}

abstract class NotebookPersistenceObservers {
  Future<Stream<Notebook>> watchNotebookById(String id);
  Future<Stream<List<Notebook>>> watchAllNotebooks();
}
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

abstract class NotebookApplicationService {
  // Notebook Commands Methods
  Future<void> createNotebook();
  Future<void> updateNotebook(String id);
  Future<void> softDeleteNotebook(String id);
  Future<void> hardDeleteNotebook(String id);
  Future<void> restoreNotebook(String id);
  
  // Notebook Queries Methods
  Future<Notebook?> getNotebookById(String id);
  Future<List<Notebook>> getAllNotebooks();
  
  // Notebook Observer Methods
  Future<Stream<Notebook>> watchNotebookById(String id);
  Future<Stream<List<Notebook>>> watchAllNotebooks();
}
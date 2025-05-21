// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';



class WatchNotebookByIdUseCase {
  const WatchNotebookByIdUseCase(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  Stream<NotebookDTO> execute(String notebookId) {
    return _repository.observers.watchNotebookById(notebookId);
  }
}
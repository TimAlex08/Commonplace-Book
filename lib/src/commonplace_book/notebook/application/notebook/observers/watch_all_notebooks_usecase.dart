// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



class WatchAllNotebooksUsecase {
  const WatchAllNotebooksUsecase(this._repository);
  final ForPersitingNotebooksPort _repository;
  
  Stream<List<NotebookDTO>> execute() {
    return _repository.observers.watchAllNotebooks();
  }
}
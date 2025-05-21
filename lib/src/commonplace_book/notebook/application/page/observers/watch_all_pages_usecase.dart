// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class WatchAllPagesUseCase {
  const WatchAllPagesUseCase(this._repository);
  final ForPersistingPagePort _repository;
  
  Stream<List<PageDTO>> execute() {
    return _repository.observers.watchAllPages();
  }
}
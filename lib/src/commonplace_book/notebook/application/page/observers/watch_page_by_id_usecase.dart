// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class WatchPageByIdUseCase {
  const WatchPageByIdUseCase(this._repository);
  final ForPersistingPagePort _repository;
  
  Stream<PageDTO> execute(String pageId) {
    return _repository.observers.watchPageById(pageId);
  }
}
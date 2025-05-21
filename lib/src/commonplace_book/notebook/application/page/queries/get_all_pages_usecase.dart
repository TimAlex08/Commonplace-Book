// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class GetAllPagesUseCase {
  const GetAllPagesUseCase(this._repository);
  final ForPersistingPagesPort _repository;
  
  Future<Result<List<PageDTO>, List<Failure>>> execute() async {
    /// Obtiene todos los pages de la base de datos.
    final result = await _repository.queries.getAllPages();
    
    return result.fold(
      (pages) => Result.success(pages ?? []),
      (failures) => Result.failure([failures]),
    );
  }
}
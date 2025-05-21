// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class GetPageByIdUseCase {
  const GetPageByIdUseCase(this._repository);
  final ForPersistingPagePort _repository;
  
  Future<Result<PageDTO, List<Failure>>> execute(String notebookId) async {
    /// Obtiene un page por su ID de la base de datos.
    final result = await _repository.queries.getPageById(notebookId);
    
    return result.fold(
      (notebook) => Result.success(notebook!),
      (failures) => Result.failure([failures]),
    );
  }
}
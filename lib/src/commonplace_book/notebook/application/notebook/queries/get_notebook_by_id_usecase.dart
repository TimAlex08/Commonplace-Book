// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



class GetNotebookByIdUseCase {
  const GetNotebookByIdUseCase(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  Future<Result<NotebookDTO, List<Failure>>> execute(String notebookId) async {
    /// Obtiene un notebook por su ID de la base de datos.
    final result = await _repository.queries.getNotebookById(notebookId);
    
    return result.fold(
      (notebook) => Result.success(notebook!),
      (failures) => Result.failure([failures]),
    );
  }
}
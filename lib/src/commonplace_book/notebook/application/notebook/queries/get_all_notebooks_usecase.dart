// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



class GetAllNotebooksUsecase {
  const GetAllNotebooksUsecase(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  Future<Result<List<NotebookDTO>, List<Failure>>> execute() async {
    /// Obtiene todos los notebooks de la base de datos.
    final result = await _repository.queries.getAllNotebooks();
    
    return result.fold(
      (notebooks) => Result.success(notebooks ?? []),
      (failures) => Result.failure([failures]),
    );
  }
}
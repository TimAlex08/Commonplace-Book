

import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';

class UpdateNotebookUsecase {
  const UpdateNotebookUsecase(this._repository);
  
  final ForPersitingNotebooksPort _repository;
  
  Future<Result<int, List<Failure>>> execute(NotebookDTO dto) async {
    /// Recibe un objeto `NotebookDTO` y lo convierte a un objeto `NotebookParams`.
    final notebook = dto.toDomainParams();
    
    /// El método `create` de la clase `Notebook` recibe un objeto `NotebookParams` y devuelve un
    /// `Result<Notebook, List<DomainFailure>>` que contiene el objeto `Notebook` o una lista de fallos.
    final validateNotebookResult = Notebook.create(notebook);
    
        // Si hay fallos, retorna el resultado fallido.
    if(validateNotebookResult.isFailure) {
      final failures = validateNotebookResult.getFailure();
      logFailure(failures);
      
      return Result.failure(failures);
    }
    
    // Si el notebook es válido, proceder con la creación
    final validNotebook = validateNotebookResult.getSuccess();
    final result = await _repository.commands.updateNotebook(validNotebook);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
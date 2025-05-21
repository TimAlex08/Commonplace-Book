// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';



class UpdateNotebookUseCase {
  const UpdateNotebookUseCase(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  Future<Result<int, List<Failure>>> execute(NotebookDTO dto) async {
    /// Genera el ID y las fechas de creación y actualización.
    /// Luego genera los NotebookParams a partir del DTO completo.
    final completedDto = dto.copyWith(
      updatedAt: DateTime.now(),
    );
    final notebook = NotebookDomainMapper.toParams(completedDto);
    
    /// El método `create` de la clase `Notebook` recibe un objeto `NotebookParams` y devuelve un
    /// `Result<Notebook, List<DomainFailure>>` que contiene el objeto `Notebook` o una lista de fallos.
    final validateNotebookResult = Notebook.create(notebook);
    
    if(validateNotebookResult.isFailure) {
      final failures = validateNotebookResult.getFailure();
      return Result.failure(failures);
    }
    
    // Si el notebook es válido, proceder con la actualización.
    final validNotebook = validateNotebookResult.getSuccess();
    final result = await _repository.commands.updateNotebook(validNotebook);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
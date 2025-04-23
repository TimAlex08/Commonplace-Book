// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



class CreateNotebookUseCase {
  const CreateNotebookUseCase(this._repository);
  final ForPersitingNotebooksPort _repository;
  
  
  Future<Result<void, List<DomainFailure>>> execute(NotebookDTO dto) async {
    /// Recibe un objeto `NotebookDTO` y lo convierte a un objeto `NotebookParams`.
    final notebook = dto.toDomainParams();
    
    /// El método `create` de la clase `Notebook` recibe un objeto `NotebookParams` y devuelve un
    /// `Result<Notebook, List<DomainFailure>>` que contiene el objeto `Notebook` o una lista de fallos.
    final validateNotebookResult = Notebook.create(notebook);
    
    // Si hay fallos, retorna el resultado fallido.
    if(validateNotebookResult.isFailure) {
      return Result.failure(validateNotebookResult.getFailure());
    }
    
    // Si el notebook es válido, proceder con la creación
    final validNotebook = validateNotebookResult.getSuccess();
    await _repository.commands.createNotebook(validNotebook);

    // Retornar resultado exitoso
    return Result.success(null);
  }
}


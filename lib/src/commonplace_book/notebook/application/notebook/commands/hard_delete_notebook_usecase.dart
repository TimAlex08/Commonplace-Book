// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';



class HardDeleteNotebookUseCase {
  const HardDeleteNotebookUseCase(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  Future<Result<int, List<Failure>>> execute(String notebookId) async {
    // Ejecuta el comando de eliminación dura en el repositorio.
    final result = await _repository.commands.hardDeleteNotebook(notebookId);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
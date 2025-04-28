// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';



class HardDeleteNotebookUsecase {
  const HardDeleteNotebookUsecase(this._repository);
  final ForPersitingNotebooksPort _repository;
  
  Future<Result<int, List<Failure>>> execute(String notebookId) async {
    // Ejecuta el comando de eliminación dura en el repositorio
    final result = await _repository.commands.hardDeleteNotebook(notebookId);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class HardDeletePageUseCase {
  const HardDeletePageUseCase(this._repository);
  final ForPersistingPagesPort _repository;
  
  Future<Result<int, List<Failure>>> execute(String pageId) async {
    // Ejecuta el comando de eliminación dura en el repositorio.
    final result = await _repository.commands.hardDeletePage(pageId);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}
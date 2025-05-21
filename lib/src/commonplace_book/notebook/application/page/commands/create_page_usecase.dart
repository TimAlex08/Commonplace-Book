// External Imports
import 'package:uuid/v4.dart';

// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';



class CreatePageUseCase {
  const CreatePageUseCase(this._repository);
  final ForPersistingPagePort _repository;
  
  Future<Result<int, List<Failure>>> execute(PageDTO dto) async {
    /// Genera el ID y las fechas de creación y actualización. 
    /// Luego genera los PageParams a partir del DTO completo.
    final completedDto = dto.copyWith(
      id: UuidV4().generate(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final page = PageDomainMapper.toParams(completedDto);
    
    /// El método `create` de la clase `Page` recibe un objeto `PageParams` y devuelve un
    /// `Result<Page, List<DomainFailure>>` que contiene el objeto `Page` o una lista de fallos.
    final validatePageResult = Page.create(page);
    
    if(validatePageResult.isFailure) {
      final failures = validatePageResult.getFailure();
      return Result.failure(failures);
    }
    
    // TODO: Añadir validacion NotebookStructure
    // Si la página es válido, proceder con la creación.
    final validPage = validatePageResult.getSuccess();
    final result = await _repository.commands.createPage(validPage);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures])
    );
  }
}
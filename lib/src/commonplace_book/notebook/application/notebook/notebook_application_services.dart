// External Imports.
import 'package:uuid/v4.dart';

// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';



class NotebookApplicationServices implements ForManagingNotebooksPort {
  const NotebookApplicationServices(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  @override
  NotebookManagementCommands get command => _NotebookCommandHandler(_repository);

  @override
  NotebookManagementQueries get query => _NotebookQueriesHandler(_repository);

  @override
  NotebookManagementObservers get observer => _NotebookObserversHandler(_repository);
}



class _NotebookCommandHandler implements NotebookManagementCommands {
  const _NotebookCommandHandler(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  @override
  Future<Result<int, List<Failure>>> createNotebook(NotebookDTO notebookDto) async {
    /// 1.- Genera el ID y las fechas de creación y actualización. 
    /// Luego genera los NotebookParams a partir del DTO completo.
    final completedDto = notebookDto.copyWith(
      id: UuidV4().generate(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final notebook = NotebookDomainMapper.toParams(completedDto);
    
    /// 2.- El método `create` de la clase `Notebook` recibe un objeto `NotebookParams` y devuelve un
    /// `Result<Notebook, List<DomainFailure>>` que contiene el objeto `Notebook` o una lista de fallos.
    final validateNotebookResult = Notebook.create(notebook);
    
    if(validateNotebookResult.isFailure) {
      final failures = validateNotebookResult.getFailure();
      return Result.failure(failures);
    }
    
    // 3.- Si el notebook es válido, proceder con la creación.
    final validNotebook = validateNotebookResult.getSuccess();
    final result = await _repository.commands.createNotebook(validNotebook);

    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }

  @override
  Future<Result<int, List<Failure>>> updateNotebook(NotebookDTO notebookDto) async {
    /// 1.- Genera el ID y las fechas de creación y actualización.
    /// Luego genera los NotebookParams a partir del DTO completo.
    final completedDto = notebookDto.copyWith(
      updatedAt: DateTime.now(),
    );
    final notebook = NotebookDomainMapper.toParams(completedDto);
    
    /// 2.- El método `create` de la clase `Notebook` recibe un objeto `NotebookParams` y devuelve un
    /// `Result<Notebook, List<DomainFailure>>` que contiene el objeto `Notebook` o una lista de fallos.
    final validateNotebookResult = Notebook.create(notebook);
    
    if(validateNotebookResult.isFailure) {
      final failures = validateNotebookResult.getFailure();
      return Result.failure(failures);
    }
    
    // 3.- Si el notebook es válido, proceder con la actualización.
    final validNotebook = validateNotebookResult.getSuccess();
    final result = await _repository.commands.updateNotebook(validNotebook);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }

  @override
  Future<Result<int, List<Failure>>> hardDeleteNotebook(String notebookId) async {
    // 1.- Ejecuta el comando de eliminación dura en el repositorio.
    final result = await _repository.commands.hardDeleteNotebook(notebookId);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure([failures]),
    );
  }
}



class _NotebookQueriesHandler implements NotebookManagementQueries {
  const _NotebookQueriesHandler(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  @override
  Future<Result<List<NotebookDTO>, List<Failure>>> getAllNotebooks() async{
    /// 1.- Obtiene todos los notebooks de la base de datos.
    final result = await _repository.queries.getAllNotebooks();
    
    return result.fold(
      (notebooks) => Result.success(notebooks),
      (failures) => Result.failure([failures]),
    );
  }

  @override
  Future<Result<NotebookDTO, List<Failure>>> getNotebookById(String notebookId) async {
    /// 1.- Obtiene un notebook por su ID de la base de datos.
    final result = await _repository.queries.getNotebookById(notebookId);
    
    return result.fold(
      (notebook) => Result.success(notebook!),
      (failures) => Result.failure([failures]),
    );
  }
}



class _NotebookObserversHandler implements NotebookManagementObservers {
  const _NotebookObserversHandler(this._repository);
  final ForPersistingNotebooksPort _repository;
  
  @override
  Stream<List<NotebookDTO>> watchAllNotebooks() {
    return _repository.observers.watchAllNotebooks();
  }

  @override
  Stream<NotebookDTO> watchNotebookById(String notebookId) {
    return _repository.observers.watchNotebookById(notebookId);
  }
}
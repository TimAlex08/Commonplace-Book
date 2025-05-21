// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Application
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/create_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/hard_delete_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/update_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/observers/watch_all_notebooks_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/observers/watch_notebook_by_id_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/queries/get_all_notebooks_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/queries/get_notebook_by_id_usecase.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



/// NotebookManagerAdapter: Adaptador para la gestión de `Notebook` en la aplicación.
class NotebookManagerAdapter implements ForManagingNotebooksPort {
  const NotebookManagerAdapter({
    required CreateNotebookUseCase createNotebook,
    required UpdateNotebookUseCase updateNotebook,
    required HardDeleteNotebookUseCase hardDeleteNotebook,
    required GetAllNotebooksUseCase getAllNotebooks,
    required GetNotebookByIdUseCase getNotebookById,
    required WatchAllNotebooksUseCase watchAllNotebooks,
    required WatchNotebookByIdUseCase watchNotebookById,
  })  : _createNotebook = createNotebook,
        _updateNotebook = updateNotebook,
        _hardDeleteNotebook = hardDeleteNotebook,
        _getAllNotebooks = getAllNotebooks,
        _getNotebookById = getNotebookById,
        _watchAllNotebooks = watchAllNotebooks,
        _watchNotebookById = watchNotebookById;
  
  final CreateNotebookUseCase _createNotebook;
  final UpdateNotebookUseCase _updateNotebook;
  final HardDeleteNotebookUseCase _hardDeleteNotebook;
  
  final GetAllNotebooksUseCase _getAllNotebooks;
  final GetNotebookByIdUseCase _getNotebookById;
  
  final WatchAllNotebooksUseCase _watchAllNotebooks;
  final WatchNotebookByIdUseCase _watchNotebookById;
  
  @override
  NotebookManagementCommands get command => _NotebookManagementCommandsImpl(_createNotebook, _updateNotebook, _hardDeleteNotebook,);
  
  @override
  NotebookManagementQueries get query => _NotebookManagementQueriesImpl(_getAllNotebooks, _getNotebookById);
  
  @override
  NotebookManagementObservers get observer => _NotebookManagementObserversImpl(_watchAllNotebooks, _watchNotebookById);
}



/// NotebookManagementCommandsImpl: Implementación de los comandos para la gestión de `Notebook`.
class _NotebookManagementCommandsImpl implements NotebookManagementCommands {
  const _NotebookManagementCommandsImpl(
    this._create,
    this._update,
    this._delete,
  );

  final CreateNotebookUseCase _create;
  final UpdateNotebookUseCase _update;
  final HardDeleteNotebookUseCase _delete;

  @override
  /// CreateNotebook: Crea un nuevo `Notebook` en la base de datos.
  Future<Result<int, List<Failure>>> createNotebook(NotebookDTO dto) async {
    final result = await _create.execute(dto);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }

  @override
  /// UpdateNotebook: Actualiza un `Notebook` existente en la base de datos.
  Future<Result<int, List<Failure>>> updateNotebook(NotebookDTO dto) async {
    final result = await _update.execute(dto);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }

  @override
  /// HardDeleteNotebook: Elimina un `Notebook` de la base de datos.
  Future<Result<int, List<Failure>>> hardDeleteNotebook(String id) async {
    final result = await _delete.execute(id);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }
}



/// NotebookManagementQueriesImpl: Implementación de las consultas para la gestión de `Notebook`.
class _NotebookManagementQueriesImpl implements NotebookManagementQueries {
  const _NotebookManagementQueriesImpl(
    this._getAllNotebooks,
    this._getNotebookById,
  );
  
  final GetAllNotebooksUseCase _getAllNotebooks;
  final GetNotebookByIdUseCase _getNotebookById;
  
  @override
  /// GetAllNotebooks: Obtiene todos los `Notebook` de la base de datos.
  Future<Result<List<NotebookDTO>, List<Failure>>> getAllNotebooks() async{
    final result = await _getAllNotebooks.execute();
    
    return result.fold(
      (notebooks) => Result.success(notebooks),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }

  @override
  /// GetNotebookById: Obtiene un `Notebook` por su ID.
  Future<Result<NotebookDTO, List<Failure>>> getNotebookById(String id) async{
    final result = await _getNotebookById.execute(id);
    
    return result.fold(
      (notebook) => Result.success(notebook),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }
}



/// NotebookManagementObserversImpl: Implementación de los observadores para la gestión de `Notebook`.
class _NotebookManagementObserversImpl implements NotebookManagementObservers {
  const _NotebookManagementObserversImpl(
    this._watchAllNotebooks,
    this._watchNotebookById,
  );
  
  final WatchAllNotebooksUseCase _watchAllNotebooks;
  final WatchNotebookByIdUseCase _watchNotebookById;
  
  @override
  /// WatchAllNotebooks: Observa todos los `Notebook` de la base de datos.
  Stream<List<NotebookDTO>> watchAllNotebooks() {
    return _watchAllNotebooks.execute();
  }

  @override
  /// WatchNotebookById: Observa un `Notebook` por su ID.
  Stream<NotebookDTO> watchNotebookById(String id) {
    return _watchNotebookById.execute(id);
  }
}
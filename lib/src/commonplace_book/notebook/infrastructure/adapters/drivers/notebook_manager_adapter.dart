// Application
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/create_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/hard_delete_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/commands/update_notebook_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/observers/watch_all_notebooks_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/observers/watch_notebook_by_id_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/queries/get_all_notebooks_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/queries/get_notebook_by_id_usecase.dart';

// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



class NotebookManagerAdapter implements ForManagingNotebooks {
  const NotebookManagerAdapter({
    required CreateNotebookUseCase createNotebook,
    required UpdateNotebookUsecase updateNotebook,
    required HardDeleteNotebookUsecase hardDeleteNotebook,
    required GetAllNotebooksUsecase getAllNotebooks,
    required GetNotebookByIdUseCase getNotebookById,
    required WatchAllNotebooksUsecase watchAllNotebooks,
    required WatchNotebookByIdUsecase watchNotebookById,
  })  : _createNotebook = createNotebook,
        _updateNotebook = updateNotebook,
        _hardDeleteNotebook = hardDeleteNotebook,
        _getAllNotebooks = getAllNotebooks,
        _getNotebookById = getNotebookById,
        _watchAllNotebooks = watchAllNotebooks,
        _watchNotebookById = watchNotebookById;
  
  final CreateNotebookUseCase _createNotebook;
  final UpdateNotebookUsecase _updateNotebook;
  final HardDeleteNotebookUsecase _hardDeleteNotebook;
  
  final GetAllNotebooksUsecase _getAllNotebooks;
  final GetNotebookByIdUseCase _getNotebookById;
  
  final WatchAllNotebooksUsecase _watchAllNotebooks;
  final WatchNotebookByIdUsecase _watchNotebookById;
  
  @override
  NotebookManagementCommands get command => _NotebookManagementCommandsImpl(_createNotebook, _updateNotebook, _hardDeleteNotebook,);
  
  @override
  NotebookManagementQueries get query => _NotebookManagementQueriesImpl(_getAllNotebooks, _getNotebookById);
  
  @override
  NotebookManagementObservers get observer => _NotebookManagementObserversImpl(_watchAllNotebooks, _watchNotebookById);
}



class _NotebookManagementCommandsImpl implements NotebookManagementCommands {
  const _NotebookManagementCommandsImpl(
    this._create,
    this._update,
    this._delete,
  );

  final CreateNotebookUseCase _create;
  final UpdateNotebookUsecase _update;
  final HardDeleteNotebookUsecase _delete;

  @override
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

  @override
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
}



class _NotebookManagementQueriesImpl implements NotebookManagementQueries {
  const _NotebookManagementQueriesImpl(
    this._getAllNotebooks,
    this._getNotebookById,
  );
  
  final GetAllNotebooksUsecase _getAllNotebooks;
  final GetNotebookByIdUseCase _getNotebookById;
  
  @override
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



class _NotebookManagementObserversImpl implements NotebookManagementObservers {
  const _NotebookManagementObserversImpl(
    this._watchAllNotebooks,
    this._watchNotebookById,
  );
  
  final WatchAllNotebooksUsecase _watchAllNotebooks;
  final WatchNotebookByIdUsecase _watchNotebookById;
  
  @override
  Stream<List<NotebookDTO>> watchAllNotebooks() {
    return _watchAllNotebooks.execute();
  }

  @override
  Stream<NotebookDTO> watchNotebookById(String id) {
    return _watchNotebookById.execute(id);
  }
}
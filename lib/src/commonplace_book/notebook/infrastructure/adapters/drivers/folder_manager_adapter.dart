// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Application
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/commands/create_folder_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/commands/hard_delete_folder_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/commands/update_folder_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/observers/watch_all_folders_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/observers/watch_folder_by_id_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/queries/get_all_folders_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/queries/get_folder_by_id_usecase.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_folders_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



/// FolderManagerAdapter: Adaptador para la gestión de `Folder` en la aplicación.
class FolderManagerAdapter implements ForManagingFoldersPort {
  const FolderManagerAdapter({
    required CreateFolderUseCase createFolder,
    required UpdateFolderUseCase updateFolder,
    required HardDeleteFolderUseCase hardDeleteFolder,
    required GetAllFoldersUseCase getAllFolders,
    required GetFolderByIdUseCase getFolderById,
    required WatchAllFoldersUseCase watchAllFolders,
    required WatchFolderByIdUseCase watchFolderById,
  }) : _createFolder = createFolder,
       _updateFolder = updateFolder,
       _hardDeleteFolder = hardDeleteFolder,
       _getAllFolders = getAllFolders,
       _getFolderById = getFolderById,
       _watchAllFolders = watchAllFolders,
       _watchFolderById = watchFolderById;
  
  final CreateFolderUseCase _createFolder;
  final UpdateFolderUseCase _updateFolder;
  final HardDeleteFolderUseCase _hardDeleteFolder;
  
  final GetAllFoldersUseCase _getAllFolders;
  final GetFolderByIdUseCase _getFolderById;
  
  final WatchAllFoldersUseCase _watchAllFolders;
  final WatchFolderByIdUseCase _watchFolderById;
  
  @override
  FolderManagementCommands get command => _FolderManagementCommandsImpl(_createFolder, _updateFolder, _hardDeleteFolder);

  @override
  FolderManagementQueries get query => _FolderManagementQueriesImpl(_getAllFolders, _getFolderById);

  @override
  FolderManagementObservers get observer => _FolderManagementObserversImpl(_watchAllFolders, _watchFolderById);
}



/// FolderManagementCommandsImpl: Implementación de los comandos para la gestión de `Folder`.
class _FolderManagementCommandsImpl implements FolderManagementCommands {
  const _FolderManagementCommandsImpl(
    this._create,
    this._update,
    this._delete,
  );

  final CreateFolderUseCase _create;
  final UpdateFolderUseCase _update;
  final HardDeleteFolderUseCase _delete;

  @override
  /// CreateFolder: Crea un nuevo `Folder` en la base de datos.
  Future<Result<int, List<Failure>>> createFolder(FolderDTO dto) async {
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
  /// UpdateFolder: Actualiza un `Folder` existente en la base de datos.
  Future<Result<int, List<Failure>>> updateFolder(FolderDTO dto) async {
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
  /// HardDeleteFolder: Elimina un `Folder` de la base de datos.
  Future<Result<int, List<Failure>>> hardDeleteFolder(String id) async {
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



/// FolderManagementQueriesImpl: Implementación de las consultas para la gestión de `Folder`.
class _FolderManagementQueriesImpl implements FolderManagementQueries {
  const _FolderManagementQueriesImpl(
    this._getAllFolders,
    this._getFolderById,
  );
  
  final GetAllFoldersUseCase _getAllFolders;
  final GetFolderByIdUseCase _getFolderById;
  
  @override
  /// GetAllFolders: Obtiene todos los `Folder` de la base de datos.
  Future<Result<List<FolderDTO>, List<Failure>>> getAllFolders() async{
    final result = await _getAllFolders.execute();
    
    return result.fold(
      (folders) => Result.success(folders),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }
  
  @override
  /// GetFolderById: Obtiene un `Folder` por su ID de la base de datos.
  Future<Result<FolderDTO, List<Failure>>> getFolderById(String id) async{
    final result = await _getFolderById.execute(id);
    
    return result.fold(
      (folders) => Result.success(folders),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      } 
    );
  }
}



/// FolderManagementObserversImpl: Implementación de los observadores para la gestión de `Folder`.
class _FolderManagementObserversImpl implements FolderManagementObservers {
  const _FolderManagementObserversImpl(
    this._watchAllFolders,
    this._watchFolderById,
  );
  
  final WatchAllFoldersUseCase _watchAllFolders;
  final WatchFolderByIdUseCase _watchFolderById;
  
  @override
  /// WatchAllFolders: Observa todos los `Folder` de la base de datos.
  Stream<List<FolderDTO>> watchAllFolders() {
    return _watchAllFolders.execute();
  }

  @override
  /// WatchFolderById: Observa un `Folder` por su ID en la base de datos.
  Stream<FolderDTO> watchFolderById(String id) {
    return _watchFolderById.execute(id);
  }
}
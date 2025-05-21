// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Application
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/commands/create_page_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/commands/hard_delete_page_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/commands/update_page_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/observers/watch_all_pages_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/observers/watch_page_by_id_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/queries/get_all_pages_usecase.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/queries/get_page_by_id_usecase.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_pages_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



class PageManagerAdapter implements ForManagingPagesPort{
  const PageManagerAdapter({
    required CreatePageUseCase createPage,
    required UpdatePageUseCase updatePage,
    required HardDeletePageUseCase hardDeletePage,
    required GetAllPagesUseCase getAllPages,
    required GetPageByIdUseCase getPageById,
    required WatchAllPagesUseCase watchAllPages,
    required WatchPageByIdUseCase watchPageById,
  })  : _createPage = createPage,
        _updatePage = updatePage,
        _hardDeletePage = hardDeletePage,
        _getAllPages = getAllPages,
        _getPageById = getPageById,
        _watchAllPages = watchAllPages,
        _watchPageById = watchPageById;
  
  final CreatePageUseCase _createPage;
  final UpdatePageUseCase _updatePage;
  final HardDeletePageUseCase _hardDeletePage;
  
  final GetAllPagesUseCase _getAllPages;
  final GetPageByIdUseCase _getPageById;
  
  final WatchAllPagesUseCase _watchAllPages;
  final WatchPageByIdUseCase _watchPageById;
  
  @override
  PageManagementCommands get command =>_PageManagementCommandsImpl(_createPage, _updatePage, _hardDeletePage);
  
  @override
  PageManagementQueries get query => throw _PageManagementQueriesImpl(_getAllPages, _getPageById);
  
  @override
  PageManagementObservers get observer => _PageManagementObserversImpl(_watchAllPages, _watchPageById);
}



/// PageManagementCommandsImpl: Implementación de los comandos para la gestión de `Page`.
class _PageManagementCommandsImpl implements PageManagementCommands {
  const _PageManagementCommandsImpl(
    this._create,
    this._update,
    this._delete,
  );
  
  final CreatePageUseCase _create;
  final UpdatePageUseCase _update;
  final HardDeletePageUseCase _delete;
  
  @override
  /// CreatePage: Crea un nuevo `Page` en la base de datos.
  Future<Result<int, List<Failure>>> createPage(PageDTO page) async {
    final result = await _create.execute(page);
    
    return result.fold(
      (success) => Result.success(success),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
  
  @override
  /// UpdatePage: Actualiza un `Page` existente en la base de datos.
  Future<Result<int, List<Failure>>> updatePage(PageDTO page) async{
    final result = await _update.execute(page);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
  
  @override
  /// HardDeletePage: Elimina un `Page` de la base de datos.
  Future<Result<int, List<Failure>>> hardDeletePage(String id) async {
    final result = await _delete.execute(id);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
}



/// PageManagementQueriesImpl: Implementación de las consultas para la gestión de `Page`.
class _PageManagementQueriesImpl implements PageManagementQueries {
  const _PageManagementQueriesImpl(
    this._getAllPages,
    this._getPageById,
  );
  
  final GetAllPagesUseCase _getAllPages;
  final GetPageByIdUseCase _getPageById;
  
  @override
  /// GetAllPages: Obtiene todos los `Page` de la base de datos.
  Future<Result<List<PageDTO>, List<Failure>>> getAllPages() async {
    final result = await _getAllPages.execute();
    
    return result.fold(
      (success) => Result.success(success),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
  
  @override
  /// GetPageById: Obtiene un `Page` por su ID.
  Future<Result<PageDTO, List<Failure>>> getPageById(String id) async {
    final result = await _getPageById.execute(id);
    
    return result.fold(
      (success) => Result.success(success),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
}



/// PageManagementObserversImpl: Implementación de los observadores para la gestión de `Page`.
class _PageManagementObserversImpl implements PageManagementObservers {
  const _PageManagementObserversImpl(
    this._watchAllPages,
    this._watchPageById,
  );
  
  final WatchAllPagesUseCase _watchAllPages;
  final WatchPageByIdUseCase _watchPageById;
  
  @override
  /// WatchAllPages: Observa todos los `Page` de la base de datos.
  Stream<List<PageDTO>> watchAllPages() {
    return _watchAllPages.execute();
  } 
  
  @override
  /// WatchPageById: Observa un `Page` por su ID.
  Stream<PageDTO> watchPageById(String id) {
    return _watchPageById.execute(id);
  } 
}
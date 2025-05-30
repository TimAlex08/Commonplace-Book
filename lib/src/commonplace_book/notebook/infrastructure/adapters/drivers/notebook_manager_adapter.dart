

// Infrastructure
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

class NotebookManagerAdapter {
  const NotebookManagerAdapter(this._port);
  
  final ForManagingNotebooksPort _port;
  
  // ----- Comandos ----- //
  Future<Result<int, List<Failure>>> createNotebook(NotebookUiModel uiModel) async {
    final dto = uiModel.toDto();
    final result = await _port.command.createNotebook(dto);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure(failures) 
    );
  }
  
  Future<Result<int, List<Failure>>> updateNotebook(NotebookUiModel uiModel) async {
    final dto = uiModel.toDto();
    final result = await _port.command.createNotebook(dto);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) => Result.failure(failures) 
    );
  }
  
  Future<Result<int, List<Failure>>> hardDeleteNotebook(String notebookId) async {
    final result = await _port.command.hardDeleteNotebook(notebookId);
    
    return result.fold(
      (rowAffected) => Result.success(rowAffected),
      (failures) => Result.failure(failures),
    );
  }
  
  // ----- Consultas ----- //
  Future<Result<List<NotebookUiModel>, List<Failure>>> getAllNotebooks() async {
    final result = await _port.query.getAllNotebooks();
  
    return result.fold(
      (dtos) {
        final uiModels = dtos.map((dto) => NotebookUiModel.fromDto(dto)).toList();
        return Result.success(uiModels);
      },
      (failures) => Result.failure(failures),
    );
  }
  
  Future<Result<NotebookUiModel, List<Failure>>> getNotebookById(String id) async {
    final result = await _port.query.getNotebookById(id);
  
    return result.fold(
      (dto) {
        final uiModel = NotebookUiModel.fromDto(dto);
        return Result.success(uiModel);
      },
      (failures) => Result.failure(failures),
    );
  }
  
  // ----- Observadores ----- //
  Stream<List<NotebookUiModel>> watchAllNotebooks() {
    return _port.observer.watchAllNotebooks().map((dtos) {
      final uiModels = dtos.map((dto) => NotebookUiModel.fromDto(dto)).toList();
      return uiModels;
    });
  }
  
  Stream<NotebookUiModel> watchNotebookById(String id) {
    return _port.observer.watchNotebookById(id).map((dto) {
      final uiModel = NotebookUiModel.fromDto(dto);
      return uiModel;
    });
  }
}
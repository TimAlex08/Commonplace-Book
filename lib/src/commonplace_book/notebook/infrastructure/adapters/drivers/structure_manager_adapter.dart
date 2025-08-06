// External Imports.
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_ui_model.dart';

// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_structures_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



class StructureManagerAdapter  {
  StructureManagerAdapter(this._port);
 
  final ForManagingStructuresPort _port;
 
  // ----- Comandos ----- //
  Future<Result<int, List<Failure>>> createStructureItem({required StructureUiModel structureUiModel, required String title, required String type}) async {
    final structureDto = structureUiModel.toDto();
    final result = await _port.command.createStructureItem(structureDto: structureDto, title: title);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      }
    );
  }
  
  Future<Result<int, List<Failure>>> reorderStructureItem({
    required String notebookId,
    required String draggedItemId,
    required String? newParentId,
    required int newPosition,
  }) async {
    final result = await _port.command.reorderStructureItem(
      notebookId: notebookId,
      draggedItemId: draggedItemId,
      newParentId: newParentId,
      newPosition: newPosition
    );
    
    return result.fold(
      (rowsAffected) => Result.success(rowsAffected),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      },
    );
  }
  
  
  // ---------- Consultas ---------- //
  Future<Result<List<StructureUiModel>, List<Failure>>> getNotebookStructures({required String notebookId}) async {
    final result = await _port.query.getNotebookStructure(notebookId);
    
    return result.fold(
      (dtos) {
        final uiModels = dtos.map((dto) => StructureUiModel.fromDto(dto)).toList();
        return Result.success(uiModels);
      },
      (failures) => Result.failure(failures)
    );
  }
  
  
  
  // ---------- Observadores ---------- //
  Stream<List<StructureUiModel>> watchNotebookStructure(String notebookId) {
    return _port.observer.watchNotebookStructure(notebookId).map((dtos) {
      final uiModels = dtos.map((dto) => StructureUiModel.fromDto(dto)).toList();
      return uiModels;
    });
  }
}
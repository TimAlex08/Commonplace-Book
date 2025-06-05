// External Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_ui_model.dart';

// Failures / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_structures_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



class StructureManagerAdapter  {
  StructureManagerAdapter(this._port);
 
  final ForManagingStructuresPort _port;
 
  // ----- Comandos ----- //
  Future<Result<int, List<Failure>>> createStructureItem({required StructureUiModel uiModel, required String title}) async {
    final structureDto = uiModel.toDto();
    final result = await _port.command.createStructureItem(structureDto: structureDto, title: title);
    
    return result.fold(
      (row) => Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      }
    );
  }
}
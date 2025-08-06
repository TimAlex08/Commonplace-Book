// Failure / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_pages_port.dart';
import 'package:commonplace_book/src/shared/infrastructure/failure_logger.dart';



class PageManagerAdapter {
  const PageManagerAdapter(this._port);
  final ForManagingPagesPort _port;
  
  // ----- Comandos ----- //
  Future<Result<int, List<Failure>>> updatePageTitle({required String pageId, required String newTitle}) async {
    final dto = PageDTO(id: pageId, title: newTitle);
    final result = await _port.command.updatePageTitle(dto);
    
    return result.fold(
      (row) =>  Result.success(row),
      (failures) {
        logFailure(failures);
        return Result.failure(failures);
      });
  }
}

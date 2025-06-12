// Failures / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_application_failures.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_pages_port.dart';



class PageApplicationServices implements ForManagingPagesPort {
  const PageApplicationServices(this._pageRepo);
  final ForPersistingPagesPort _pageRepo;
  
  @override
  PageManagementCommands get command => _PageCommandHandler(_pageRepo);
}



class _PageCommandHandler implements PageManagementCommands {
  const _PageCommandHandler(this._pageRepo);
  final ForPersistingPagesPort _pageRepo;
    
  @override
  Future<Result<int, List<Failure>>> updatePageTitle(PageDTO dto) async {
    final failures = <Failure>[];
    
    // 1.- Comprobar que ese page exista en la base de datos.
    final id = dto.id;
    if(id == null || id.isEmpty) throw ArgumentError('Missing page ID.');
    
    // 2.- Verificar existencia de la página.
    final dbQueryResult = await _pageRepo.queries.getPageById(id);
    
    if(dbQueryResult.isFailure) {
      failures.add(dbQueryResult.getFailure());
      return Result.failure(failures);
    }
    
    final dbPageDto = dbQueryResult.getSuccess();
    
    if(dbPageDto == null) {
      failures.add(PageNotFoundFailure(
        details: 'Page with ID $id not found in the database.',
      ));
      return Result.failure(failures);
    }
    
    final updatedDto = dbPageDto.copyWith(
      title: dto.title,
      updatedAt: DateTime.now(),
    );
    
    // 3.- Validar que sea un Page válido.
    final pageParams = PageDomainMapper.toParams(updatedDto);
    final validatePageResult = Page.create(pageParams);
    
    if(validatePageResult.isFailure) {
      failures.addAll(validatePageResult.getFailure());
      return Result.failure(failures);
    }
    
    final validPage = validatePageResult.getSuccess();
    
    // 4.- Actualizar la página en la base de datos.
    final updateResult = await _pageRepo.commands.updatePage(validPage);
    if(updateResult.isFailure) {
      failures.add(updateResult.getFailure());
      return Result.failure(failures);
    }
    
    return Result.success(updateResult.getSuccess());
  }
}
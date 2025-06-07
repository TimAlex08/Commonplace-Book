// Failures / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';



abstract class ForPersistingPagesPort {
  PagePersistenceCommands get commands;
  PagePersistenceQueries get queries;
  PagePersistenceObservers get observers;
}

abstract class PagePersistenceCommands {
  Future<Result<int, Failure>> createPage(Page page);
  Future<Result<int, Failure>> updatePage(Page notebook);
  Future<Result<int, Failure>> hardDeletePage(String id);
}

abstract class PagePersistenceQueries {
  Future<Result<List<PageDTO>?, Failure>> getAllPages();
  Future<Result<PageDTO?, Failure>> getPageById(String id);
}

abstract class PagePersistenceObservers {
  Stream<List<PageDTO>> watchAllPages();
  Stream<PageDTO> watchPageById(String id);
}
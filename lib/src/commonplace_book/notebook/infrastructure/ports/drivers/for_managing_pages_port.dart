// Failure / Result
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';



abstract class ForManagingPagesPort {
  PageManagementCommands get command;
  PageManagementQueries get query;
  PageManagementObservers get observer;
}

abstract class PageManagementCommands {
  Future<Result<int, List<Failure>>> createPage(PageDTO page);
  Future<Result<int, List<Failure>>> updatePage(PageDTO page);
  Future<Result<int, List<Failure>>> hardDeletePage(String id);
}

abstract class PageManagementQueries {
  Future<Result<List<PageDTO>, List<Failure>>> getAllPages();
  Future<Result<PageDTO, List<Failure>>> getPageById(String id);
}

abstract class PageManagementObservers {
  Stream<List<PageDTO>> watchAllPages();
  Stream<PageDTO> watchPageById(String id);
}
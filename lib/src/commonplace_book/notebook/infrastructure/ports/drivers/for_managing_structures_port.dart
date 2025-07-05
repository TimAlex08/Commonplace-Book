// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';

abstract class ForManagingStructuresPort {
  StructureManagementCommands get command;
  StructureManagementQueries get query;
  StructureManagementObservers get observer;
}

abstract class StructureManagementCommands {
  Future<Result<int, List<Failure>>> createStructureItem({
    required StructureDTO structureDto,
    required String title,
  });
  
  Future<Result<int, List<Failure>>> updateStructureItemTitle({
    required String structureId,
    required String newTitle,
  });
  
  Future<Result<void, List<Failure>>> hardDeleteStructureItem(String structureId);
  
  Future<Result<void, List<Failure>>> reorderStructureItem({
    required StructureDTO structureDto,
    required int newPosition,
  });
}

abstract class StructureManagementQueries {
  Future<Result<List<StructureDTO>, List<Failure>>> getNotebookStructure(String notebookId);
  Future<Result<StructureDTO?, List<Failure>>> getStructureById(StructureDTO structureDto);
}

abstract class StructureManagementObservers {
  Stream<List<StructureDTO>> watchNotebookStructure(String notebookId);
  Stream<StructureDTO?> watchStructureById(String structureId);
}
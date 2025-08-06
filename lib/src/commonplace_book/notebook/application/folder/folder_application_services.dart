// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_application_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_folders_port.dart';



class FolderApplicationServices implements ForManagingFoldersPort {
  const FolderApplicationServices(this._folderRepo);
  final ForPersistingFoldersPort _folderRepo;
  
  @override
  FolderManagementCommands get command => _FolderCommandHandler(_folderRepo);
}



class _FolderCommandHandler implements FolderManagementCommands {
  const _FolderCommandHandler(this._folderRepo);
  final ForPersistingFoldersPort _folderRepo;
  
  @override
  Future<Result<int, List<Failure>>> updateFolderTitle(FolderDTO dto) async {
    final failures = <Failure>[];
    
    // 1.- Comprobar que ese Folder exista en la base de datos.
    final id = dto.id;
    if(id == null || id.isEmpty) throw ArgumentError('Missing page ID.');
    
    // 2.- Verificar existencia de la carpeta.
    final dbQueryResult = await _folderRepo.queries.getFolderById(id);
    
    if(dbQueryResult.isFailure) {
      failures.add(dbQueryResult.getFailure());
      return Result.failure(failures);
    }
    
    final dbFolderDto = dbQueryResult.getSuccess();
    
    if(dbFolderDto == null) {
      failures.add(FolderNotFoundFailure(
        details: 'Folder with ID $id not found in the database.'
        ));
      return Result.failure(failures);
    }
    
    final updatedDto = dbFolderDto.copyWith(
      name: dto.name
    );
    
    // 3.- Validar que sea un Folder válido.
    final folderParams = FolderDomainMapper.toParams(updatedDto);
    final validateFolderResult = Folder.create(folderParams);
    
    if(validateFolderResult.isFailure) {
      failures.addAll(validateFolderResult.getFailure());
      return Result.failure(failures);
    }
    
    final validPage =validateFolderResult.getSuccess();
    
    // 4.- Actualizar la carpeta en la base de datos.
    final updateResult = await _folderRepo.commands.updateFolder(validPage);
    if(updateResult.isFailure) {
      failures.add(updateResult.getFailure());
      return Result.failure(failures);
    }
    
    return Result.success(updateResult.getSuccess());
  }
}
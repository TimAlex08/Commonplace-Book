// External Imports.
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/drift.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/folder.dart';



/// FolderDTO: Objecto de transferencia de datos (DTO) para la entidad Folder.
class FolderDTO {
  const FolderDTO({
    this.id,
    required this.name,
  });
  
  final String? id;
  final String name;
  
  FolderDTO copyWith({String? id, String? name}) {
    return FolderDTO(
      id: id ?? this.id,
      name: name ?? this.name
    );
  }
}



/// FolderDomainMapper: Clase de mapeo entre FolderDTO y las entidades del dominio.
/// Responsable de la transformación bidireccional entre los objetos DTO 
/// y los objetos del dominio (Folder y FolderParams).
class FolderDomainMapper {
  static FolderParams toParams(FolderDTO dto) {
    return FolderParams(
      id: dto.id,
      name: dto.name
    );
  }
  
  static FolderDTO fromDomain(Folder folder) {
    return FolderDTO(
      id: folder.id.value,
      name: folder.name.value
    );
  }
}



/// FolderDriftMapper: Clase de mapeo entre FolderDTO y las entidades de la capa de persistencia Drift.
/// Responsable de la transformación bidireccional entre los objetos DTO y los objetos de
/// la clase de la base de datos (FolderItemsCompanion y FolderItem).
/// Incluye validaciones para asegurar que los datos son apropiados para la persistencia.
class FolderDriftMapper {
  static FolderItemsCompanion toCompanion(FolderDTO dto) {
    // Verificar que todos los campos necesarios estén presentes.
    if(dto.id == null) {
      throw ArgumentError('ID must be present to persist in the database.');
    }
    
    return FolderItemsCompanion(
      id: Value(dto.id!),
      title: Value(dto.name),
    );
  }
  
  static FolderDTO fromData(FolderItem data) {
    return FolderDTO(
      id: data.id,
      name: data.title
    ); 
  }
}
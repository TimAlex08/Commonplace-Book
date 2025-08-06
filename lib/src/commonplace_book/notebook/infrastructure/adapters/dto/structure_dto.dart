// External Imports.
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/drift.dart';

// Domain.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/structure.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';



/// StructureDTO: Objeto de transferencia de datos (DTO) para la entidad Structure.
class StructureDTO {
  const StructureDTO({
    this.structureId,
    required this.notebookId,
    this.parentId,
    required this.type,
    this.folderId,
    this.pageId,
    this.position,
    this.depth,
    this.folderData,
    this.pageData,
  });
  
  final String? structureId;
  final String notebookId;
  final String? parentId;
  final String type;
  final String? folderId;
  final String? pageId;
  final int? position;
  final int? depth;
  
  final FolderDTO? folderData;
  final PageDTO? pageData;
  
  StructureDTO copyWith({
    String? structureId,
    String? notebookId,
    String? parentId,
    String? type,
    String? folderId,
    String? pageId,
    int? position,
    int? depth,
    FolderDTO? folderData,
    PageDTO? pageData,
  }) {
    return StructureDTO(
      structureId: structureId ?? this.structureId,
      notebookId: notebookId ?? this.notebookId,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      folderId: folderId ?? this.folderId,
      pageId: pageId ?? this.pageId,
      position: position ?? this.position,
      depth: depth ?? this.depth,
      folderData: folderData ?? this.folderData,
      pageData: pageData ?? this.pageData,
    );
  }
}



/// StructureDomainMapper: Clase de mapeo entre StructureDTO y las entidades del dominio.
/// Responsable de la transformación bidireccional entre los objetos DTO 
/// y los objetos del dominio (Structure y StructureParams).
class StructureDomainMapper {
  static StructureParams toParams(StructureDTO dto) {
    return StructureParams(
      structureId: dto.structureId,
      parentId: dto.parentId,
      notebookId: dto.notebookId,
      type: dto.type,
      folderId: dto.folderId,
      pageId: dto.pageId,
      position: dto.position,
      depth: dto.depth,
    );
  }
  
  static StructureDTO fromDomain(Structure structure) {
    return StructureDTO(
      structureId: structure.id.value,
      parentId: structure.parentId?.value,
      notebookId: structure.notebookId.value,
      type: structure.type.value,
      folderId: structure.elementId.folderId,
      pageId: structure.elementId.pageId,
      position: structure.position.value,
      depth: structure.depth.value,
    );
  }
}



/// StructureDriftMapper: Clase de mapeo entre StructureDTO y las entidades de la capa de persistencia Drift.
/// Responsable de la transformación bidireccional entre los objetos DTO y los objetos de
/// la clase de la base de datos (StructureItemsCompanion y StructureItem).
/// Incluye validaciones para asegurar que los datos son apropiados para la persistencia.
class StructureDriftMapper {
  static NotebookStructureItemsCompanion toCompanion(StructureDTO dto) { 
    // Verificar que todos los campos necesarios estén presentes
    final missingFields = <String>[
      if (dto.structureId == null) 'ID',
      if (dto.position == null) 'Position',
      if (dto.depth == null) 'Depth',
    ];

    if (missingFields.isNotEmpty) {
      throw ArgumentError('${missingFields.join(', ')} must be present to persist in the database.');
    }
    
    return NotebookStructureItemsCompanion(
      id: Value(dto.structureId!),
      parentId: Value(dto.parentId),
      notebookId: Value(dto.notebookId),
      type: Value(dto.type),
      folderId: Value(dto.folderId),
      pageId: Value(dto.pageId),
      position: Value(dto.position!),
      depth: Value(dto.depth!),
    );
  }
  
  static StructureDTO fromData(
    NotebookStructureItem structure,
    FolderItem? folder,
    PageItem? page,
  ) {
    return StructureDTO(
      structureId: structure.id,
      parentId: structure.parentId,
      notebookId: structure.notebookId,
      type: structure.type,
      folderId: structure.folderId,
      pageId: structure.pageId,
      position: structure.position,
      depth: structure.depth,
      folderData: folder != null 
        ? FolderDriftMapper.fromData(folder) 
        : null,
      pageData: page != null
        ? PageDriftMapper.fromData(page)
        : null,
    );
  }
  
  static StructureDTO fromQueryRow(QueryRow row) {
    return StructureDTO(
      structureId: row.read<String>('structure_id'), // Usa el nombre de la columna en la DB
      notebookId: row.read<String>('notebook_id'),
      parentId: row.readNullable<String>('parent_id'),
      type: row.read<String>('type'),
      folderId: row.readNullable<String>('folder_id'),
      pageId: row.readNullable<String>('page_id'),
      position: row.read<int>('position'),
      depth: row.read<int>('depth'),
    );
  }
}
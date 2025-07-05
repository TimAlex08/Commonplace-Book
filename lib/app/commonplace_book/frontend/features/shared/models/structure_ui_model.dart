// Internal Imports.
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/structure_dto.dart';



/// StructureUiModel: Modelo que representa un elemento de estructura dentro de una libreta.
class StructureUiModel {
  const StructureUiModel({
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
  
  final FolderUiModel? folderData;
  final PageUiModel? pageData;
  
  factory StructureUiModel.empty() {
    return StructureUiModel(
      structureId: '',
      notebookId: '',
      parentId: '',
      type: '',
      folderId: '',
      pageId: '',
      position: null,
      depth: null,
    );
  }
  
  StructureUiModel copyWith({
    String? structureId,
    String? notebookId,
    String? parentId,
    String? type,
    String? folderId,
    String? pageId,
    int? position,
    int? depth,
    FolderUiModel? folderData,
    PageUiModel? pageData,
  }) {
    return StructureUiModel(
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
  
  /// Convierte un objeto `StructureUiModel` a un objeto `StructureDTO`.
  StructureDTO toDto() {
    return StructureDTO(
      structureId: structureId,
      notebookId: notebookId,
      parentId: parentId,
      type: type,
      folderId: folderId,
      pageId: pageId,
      position: position,
      depth: depth,
      folderData: folderData?.toDto(),
      pageData: pageData?.toDto(),
    );
  }
  
  /// Crea un `StructureUiModel` a partir de un `StructureDTO`.
  factory StructureUiModel.fromDto(StructureDTO dto) {
    return StructureUiModel(
      structureId: dto.structureId,
      notebookId: dto.notebookId,
      parentId: dto.parentId,
      type: dto.type,
      folderId: dto.folderId,
      pageId: dto.pageId,
      position: dto.position,
      depth: dto.depth,
      folderData: dto.folderData != null 
        ? FolderUiModel.fromDto(dto.folderData!) 
        : null,
      pageData: dto.pageData != null
        ? PageUiModel.fromDto(dto.pageData!)
        : null,
    );
  }
  
  /// DisplayName: Método para acceder a los datos.
  /// Obtiene el nombre del elemento (carpeta o página).
  String? get displayName {
    if (type == 'folder' && folderData != null) {
      return folderData!.name;
    } else if (type == 'page' && pageData != null) {
      return pageData!.title;
    }
    return null;
  }
}
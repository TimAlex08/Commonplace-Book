


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
  });
  
  final String? structureId;
  final String notebookId;
  final String? parentId;
  final String type;
  final String? folderId;
  final String? pageId;
  final int? position;
  final int? depth;
  
  StructureUiModel copyWith({
    String? structureId,
    String? notebookId,
    String? parentId,
    String? type,
    String? folderId,
    String? pageId,
    int? position,
    int? depth,
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
    );
  }
  
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
    );
  }
}
// Models
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';



enum StructureItemType { page, folder }

extension StructureItemTypeX on StructureItemType {
  String get name {
    return switch (this) {
      StructureItemType.folder => 'folder',
      StructureItemType.page => 'page'
    };
  }
  
  static StructureItemType fromString(String value) {
    switch (value) {
      case 'folder':
        return StructureItemType.folder;
      case 'page':
        return StructureItemType.page;
      default:
        throw ArgumentError('Tipo desconocido: $value');
    }
  }
}

class StructureFormModel {
  StructureFormModel({
    required this.structureUiModel,
    required this.title,
    required this.type
  });
  
  final StructureUiModel structureUiModel;
  final String title;
  final StructureItemType type;
  
  StructureFormModel copyWith({
    StructureUiModel? structureUiModel,
    String? title,
    StructureItemType? type
  }) {
    return StructureFormModel(
      structureUiModel: structureUiModel ?? this.structureUiModel,
      title: title ?? this.title,
      type: type ?? this.type
    );
  }
  
  static StructureFormModel fromStructure({
    required StructureUiModel structureModel,
    required StructureItemType type,
  }) {
    return StructureFormModel(
      structureUiModel: structureModel,
      title: '',
      type: type,
    );
  }
}
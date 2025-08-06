// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/folder_dto.dart';



class FolderUiModel {
  const FolderUiModel({
    this.id,
    required this.title,
  });
  
  final String? id;
  final String title;
  
  FolderUiModel copyWith({
    String? id,
    String? title,
  }) {
    return FolderUiModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
  
  /// Convierte un objeto `FolderUiModel` a un `FolderDTO`.
  FolderDTO toDto() {
    return FolderDTO(
      id: id,
      name: title,
    );
  }
  
  /// Crea un objeto `FolderUiModel` a partir de un `FolderDTO`.
  factory FolderUiModel.fromDto(FolderDTO dto) {
    return FolderUiModel(
      id: dto.id,
      title: dto.name,
    );
  }
}
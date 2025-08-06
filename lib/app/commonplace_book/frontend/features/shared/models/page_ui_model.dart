// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/page_dto.dart';



class PageUiModel {
  const PageUiModel({
    this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
  
  final String? id;
  final String title;
  final DateTime? createdAt;
  final DateTime? updatedAt;



  PageUiModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PageUiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Convierte un objeto `PageUiModel` a un `PageDTO`.
  PageDTO toDto() {
    return PageDTO(
      id: id,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  /// Crea un objeto `PageUiModel` a partir de un `PageDTO`.
  factory PageUiModel.fromDto(PageDTO dto) {
    return PageUiModel(
      id: dto.id,
      title: dto.title,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
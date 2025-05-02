import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';



/// NotebookUiModel: Modelo que representa un cuaderno en la interfaz de usuario.
class NotebookUiModel {
    const NotebookUiModel({
             this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    required this.coverImagePath,
    required this.backCoverImagePath,
    required this.isFavorite,
    required this.isArchived,
    required this.isLocked
  });
  
  final String? id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String color;
  final String? coverImagePath;
  final String? backCoverImagePath;
  final bool isFavorite;
  final bool isArchived;
  final bool isLocked;
  
  factory NotebookUiModel.empty() {
    return NotebookUiModel(
      name: '', 
      description: '', 
      createdAt: '', 
      updatedAt: '', 
      color: '#FFE0E0E0', 
      coverImagePath: '', 
      backCoverImagePath: '', 
      isFavorite: false, 
      isArchived: false, 
      isLocked: false
    );
  }
  
  NotebookUiModel copyWith({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? color,
    String? coverImagePath,
    String? backCoverImagePath,
    bool? isFavorite,
    bool? isArchived,
    bool? isLocked
  }) {
    return NotebookUiModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      backCoverImagePath: backCoverImagePath ?? this.backCoverImagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
      isLocked: isLocked ?? this.isLocked
    );
  }
  
  /// Convierte un objeto `NotebookUiModel` a un objeto `NotebookDTO`.
  NotebookDTO toDto() {
    return NotebookDTO(
      id: id!, 
      name: name, 
      description: description, 
      createdAt: createdAt, 
      updatedAt: updatedAt, 
      color: color, 
      coverImagePath: coverImagePath ?? '', 
      backCoverImagePath: backCoverImagePath ?? '', 
      isFavorite: isFavorite, 
      isArchived: isArchived, 
      isLocked: isLocked,
    );
  }
  
  /// Crea un NotebookUiModel a partir de un NotebookDTO
  factory NotebookUiModel.fromDto(NotebookDTO dto) {
    return NotebookUiModel(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      color: dto.color,
      coverImagePath: dto.coverImagePath,
      backCoverImagePath: dto.backCoverImagePath,
      isFavorite: dto.isFavorite,
      isArchived: dto.isArchived,
      isLocked: dto.isLocked,
    );
  }  
}
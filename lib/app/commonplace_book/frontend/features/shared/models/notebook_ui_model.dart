// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';



/// NotebookUiModel: Modelo que representa un cuaderno en la interfaz de usuario.
class NotebookUiModel {
    const NotebookUiModel({
    this.id,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String color;
  final String coverImagePath;
  final String backCoverImagePath;
  final bool isFavorite;
  final bool isArchived;
  final bool isLocked;
  
  String get formattedCreatedAt => _formatDate(createdAt);
  String get formattedUpdatedAt => _formatDate(updatedAt);
  
  factory NotebookUiModel.empty() {
    return NotebookUiModel(
      id: '',
      name: '', 
      description: '', 
      createdAt: null, 
      updatedAt: null, 
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
    DateTime? createdAt,
    DateTime? updatedAt,
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
      coverImagePath: coverImagePath, 
      backCoverImagePath: backCoverImagePath, 
      isFavorite: isFavorite, 
      isArchived: isArchived, 
      isLocked: isLocked,
    );
  }
  
  /// Crea un NotebookUiModel a partir de un NotebookDTO.
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
  
  String _formatDate(DateTime? date) {
    if (date == null) return 'No disponible';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
  
  // String _formatFullDate(DateTime? date) {
  //   if (date == null) return 'No disponible';
  //   
  //   final formatter = DateFormat("EEEE d 'de' MMMM 'de' y", 'es_ES');
  //   String formatted = formatter.format(date);
  //   return formatted[0].toUpperCase() + formatted.substring(1);
  // }
}
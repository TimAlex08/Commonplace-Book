// External Imports
import 'package:drift/drift.dart';

// Database Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';



/// Objeto de transferencia de datos (DTO) para la entidad Notebook
class NotebookDTO {
  NotebookDTO({
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
    required this.isLocked,
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
  
  NotebookDTO copyWith({
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
    bool? isLocked,
  }) {
    return NotebookDTO(
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
      isLocked: isLocked ?? this.isLocked,
    );
  }
}



/// Clase de mapeo entre NotebookDTO y las entidades del dominio
/// 
/// Responsable de la transformación bidireccional entre los objetos DTO 
/// y los objetos del dominio (Notebook y NotebookParams)
class NotebookDomainMapper {
  static NotebookParams toParams(NotebookDTO dto) {
    return NotebookParams(
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
  
  static NotebookDTO fromDomain(Notebook notebook) {
    return NotebookDTO(
      id: notebook.id,
      name: notebook.name.value,
      description: notebook.description.value,
      createdAt: notebook.timestamp.createdAt,
      updatedAt: notebook.timestamp.updatedAt,
      color: notebook.appearence.color,
      coverImagePath: notebook.appearence.coverImagePath,
      backCoverImagePath: notebook.appearence.backCoverImagePath,
      isFavorite: notebook.state.isFavorite,
      isArchived: notebook.state.isArchived,
      isLocked: notebook.state.isLocked,
    );
  }
}



/// Clase de mapeo entre NotebookDTO y las entidades de la capa de persistencia Drift.
/// 
/// Responsable de la transformación bidireccional entre los objetos DTO y los objetos de
/// la clase de la base de datos (NotebookItemsCompanion y NotebookItem).
/// Incluye validaciones para asegurar que los datos son apropiados para la persistencia
class NotebookDriftMapper {
  static NotebookItemsCompanion toCompanion(NotebookDTO dto) {
    
    // Verificar que todos los campos necesarios estén presentes
    if(dto.id == null) {
      throw ArgumentError('ID must be present to persist in the database');
    }
    if (dto.createdAt == null) {
      throw ArgumentError('The creation date must be present to persist');
    }
    if (dto.updatedAt == null) {
      throw ArgumentError('The update date must be present to persist');
    }
    
    return NotebookItemsCompanion(
      id: Value(dto.id!),
      name: Value(dto.name),
      description: Value(dto.description),
      createdAt: Value(dto.createdAt!),
      updatedAt: Value(dto.updatedAt!),
      color: Value(dto.color),
      coverImagePath: Value(dto.coverImagePath),
      backCoverImagePath: Value(dto.backCoverImagePath),
      isFavorite: Value(dto.isFavorite),
      isArchived: Value(dto.isArchived),
      isLocked: Value(dto.isLocked),
    );
  }
  
  static NotebookDTO fromData(NotebookItem data) {
    return NotebookDTO(
      id: data.id,
      name: data.name,
      description: data.description,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      color: data.color,
      coverImagePath: data.coverImagePath,
      backCoverImagePath: data.backCoverImagePath,
      isFavorite: data.isFavorite,
      isArchived: data.isArchived,
      isLocked: data.isLocked,
    );
  }
}
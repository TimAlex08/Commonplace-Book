// External Imports
import 'package:drift/drift.dart';

// Database Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/notebook.dart';



class NotebookDTO {
  NotebookDTO({
    required this.id, 
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
  
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String color;
  final String coverImagePath;
  final String backCoverImagePath;
  final bool isFavorite;
  final bool isArchived;
  final bool isLocked;

  /* ---------- NotebookDTO a Notebook (Entidad) ---------- */
   
  /// Convierte un objeto `NotebookDTO` a un objeto `NotebookParams`.
  NotebookParams toDomainParams() {
    return NotebookParams(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      color: color,
      coverImagePath: coverImagePath,
      backCoverImagePath: backCoverImagePath,
      isFavorite: isFavorite,
      isArchived: isArchived,
      isLocked: isLocked
    );
  }
  
  
  /// Convierte un objeto `NotebookDTO` a un objeto `Notebook`.
  factory NotebookDTO.fromDomain(Notebook notebook) {
    return NotebookDTO(
      id: notebook.id,
      name: notebook.name.value,
      description: notebook.description.value,
      createdAt: notebook.timestamp.createdAt.toIso8601String(),
      updatedAt: notebook.timestamp.updatedAt.toIso8601String(),
      color: notebook.appearence.color,
      coverImagePath: notebook.appearence.coverImagePath,
      backCoverImagePath: notebook.appearence.backCoverImagePath,
      isFavorite: notebook.state.isFavorite,
      isArchived: notebook.state.isArchived,
      isLocked: notebook.state.isLocked
    );
  }
  
  
  
  /// ----- NotebookDTO a Drift ----- ///
  NotebookItemsCompanion toCompanion() {
    return NotebookItemsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(DateTime.parse(createdAt)),
      updatedAt: Value(DateTime.parse(updatedAt)),
      color: Value(color),
      coverImagePath: Value(coverImagePath),
      backCoverImagePath: Value(backCoverImagePath),
      isFavorite: Value(isFavorite),
      isArchived: Value(isArchived),
      isLocked: Value(isLocked)
    );
  }
  
  factory NotebookDTO.fromData(NotebookItem data) {
    return NotebookDTO(
      id: data.id,
      name: data.name,
      description: data.description,
      createdAt: data.createdAt.toIso8601String(),
      updatedAt: data.updatedAt.toIso8601String(),
      color: data.color,
      coverImagePath: data.coverImagePath,
      backCoverImagePath: data.backCoverImagePath,
      isFavorite: data.isFavorite,
      isArchived: data.isArchived,
      isLocked: data.isLocked
    );
  }
}
// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:drift/drift.dart';

// Domain
import 'package:commonplace_book/src/commonplace_book/notebook/domain/entities/page.dart';



/// PageDTO: Objeto de transferencia de datos (DTO) para la entidad Page.
class PageDTO {
  const PageDTO({
    this.id,
    required this.title,
    this.createdAt,
    this.updatedAt
  });
  
  final String? id;
  final String title;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  PageDTO copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PageDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}



/// PageDomainMapper: Clase de mapeo entre PageDTO y las entidades del dominio.
/// 
/// Responsable de la transformación bidireccional entre los objetos DTO 
/// y los objetos del dominio (Page y PageParams).
class PageDomainMapper {
  static PageParams toParams(PageDTO dto) {
    return PageParams(
      id: dto.id,
      title: dto.title,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
  
  static PageDTO fromDomain(Page page) {
    return PageDTO(
      id: page.id.value,
      title: page.title.value,
      createdAt: page.timestamp.createdAt,
      updatedAt: page.timestamp.updatedAt,      
    );
  }
}


/// PageDriftMapper: Clase de mapeo entre PageDTO y las entidades de la capa de persistencia Drift.
/// 
/// Responsable de la transformación bidireccional entre los objetos DTO y los objetos de
/// la clase de la base de datos (PageItemsCompanion y PageItem).
/// Incluye validaciones para asegurar que los datos son apropiados para la persistencia.
class PageDriftMapper {
  static PageItemsCompanion toCompanion(PageDTO dto) {
    
    // Verificar que todos los campos necesarios estén presentes.
    if(dto.id == null) {
      throw ArgumentError('ID must be present to persist in the database.');
    }
    if (dto.createdAt == null) {
      throw ArgumentError('The creation date must be present to persist.');
    }
    if (dto.updatedAt == null) {
      throw ArgumentError('The update date must be present to persist.');
    }
    
    return PageItemsCompanion(
      id: Value(dto.id!),
      title: Value(dto.title),
      createdAt: Value(dto.createdAt!),
      updatedAt: Value(dto.updatedAt!),
    );
  }
  
  static PageDTO fromData(PageItem data) {
    return PageDTO(
      id: data.id,
      title: data.title,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt
    );
  }
}
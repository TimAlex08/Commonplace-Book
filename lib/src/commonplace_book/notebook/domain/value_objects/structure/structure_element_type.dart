


import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

/// StructureElementType: Objeto de valor que representa el tipo de un elemento en la estructura de una libreta.
/// Puede ser una carpeta o una página. Se utiliza para validar y normalizar los tipos de elementos.
class StructureElementType {
  const StructureElementType._(this.value);
  final String value;
  
  static const String _folder = 'folder';
  static const String _page = 'page';
  
  // Lista de valores válidos para validacion.
  static const List<String> validTypes = [_folder, _page];
  
  // Factory constructors para cada tipo.
  static const StructureElementType folderType = StructureElementType._(_folder);
  static const StructureElementType pageType = StructureElementType._(_page);
  
  // Factory method para crear desde string con validación
  static Result<StructureElementType, List<DomainFailure>> validate(String? value) {
    final failures = <DomainFailure>[];
    
    if(value == null) {
      failures.add(StructureInvalidTypeFailure(
        details: 'StructureElementType cannot be null'
      )) ;
      return Result.failure(failures);
    }
    
    final normalizedInput = value.trim().toLowerCase();
    
    if(normalizedInput.isEmpty) {
      failures.add(StructureInvalidTypeFailure(
        details: 'StructureElementType cannot be empty'
      ));
    }
    
    switch(normalizedInput) {
      case _folder:
        return Result.success(folderType);
      case _page:
        return Result.success(pageType);
      default:
        failures.add(StructureInvalidTypeFailure(
          details: 'Invalid StructureElementType: "$value". '
                   'Valid types: $validTypes (case insensitive)',
        ));
        return Result.failure(failures);
    }
  }
  
  @override
  String toString() => value;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StructureElementType && runtimeType == other.runtimeType && value == other.value;
      
  @override
  int get hashCode => value.hashCode;
}
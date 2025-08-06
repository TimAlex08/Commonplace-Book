// Constants.
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// FolderName: Objeto de valor que representa el nombre de un `Folder`.
/// - Valida que el nombre no esté vacío, no exceda la longitud máxima y contenga solo caracteres permitidos.
class FolderName {
  const FolderName._(this.value);
  final String value;
  
  static Result<FolderName, List<DomainFailure>> validate(String? name) {
    final failures = <DomainFailure>[];
    
    // Valida que el nombre no sea nulo.
    if (name == null) {
      failures.add(FolderInvalidNameFailure(
        details: 'Name cannot be null.',
      ));
      return Result.failure(failures);
    }
    
    // Corta los espacios en blanco al principio y al final de la cadena de entrada.
    final trimmedName = name.trim();
    
    // Valida que el nombre no esté vacío.
    if (trimmedName.isEmpty) {
      failures.add(FolderInvalidNameFailure(
        details: 'Name cannot be empty.',
      ));
      return Result.failure(failures);
    }
    
    // Valida que el nombre no exceda la longitud máxima.
    if(trimmedName.length > NotebookConstants.maxFolderNameLength) {
      failures.add(FolderNameTooLongFailure(
        details: 'Actual Length: ${trimmedName.length}, Max Length: ${NotebookConstants.maxFolderNameLength}.',
      ));
    }
    
    // Valida que el nombre contenga solo caracteres permitidos.
    if(_isValidName(trimmedName) == false) {
      final invalidChars = _getInvalidCharacters(trimmedName);
      
      failures.add(FolderInvalidNameFailure(
        details: 'Name contains invalid characters: ${invalidChars.join(', ')}.'
      ));
    }
    
    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el nombre de la carpeta como un éxito.
    return Result.success(FolderName._(trimmedName));
  }
  
  /// NameRegExp: Permite nombres de carpetas seguros y expresivos:
  /// - Letras (incluye acentos y caracteres internacionales).
  /// - Números.
  /// - Espacios y caracteres comunes: espacio, punto, coma, guion, paréntesis, signos de exclamación, etc.
  /// - Excluye caracteres peligrosos para bases de datos: comillas, %, \, <, >, ;, =, etc.
  /// - Usa bandera 'unicode: true' para soportar caracteres multilenguaje correctamente.
  static final _nameRegExp = RegExp(r"^[\p{L}\p{N} .,!?\-()&@#]+$", unicode: true);
  
  /// ValidCharRegExp permite lo mismo que NameRegExp pero carcater por carácter.
  static final _validCharRegExp = RegExp(r"[\p{L}\p{N} .,!?\-()&@#]", unicode: true);
  
  static _isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }
  
    static Set<String> _getInvalidCharacters(String name) {
    final invalidChars = <String>{};
    
    for(var i = 0; i < name.length; i++) {
      final char = name[i];
      if(_validCharRegExp.hasMatch(char) == false) {
        invalidChars.add(char);
      }
    }
    return invalidChars;
  }
}
// Constants.
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/page_errors/page_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// PageTitle: Objeto de valor que representa el título de un `Page`.
/// - Valida que el título no esté vacío, no exceda la longitud máxima y contenga solo caracteres permitidos.
class PageTitle {
  const PageTitle._(this.value);
  final String value;
  
  /// Método que valida `PageTitle`.
  static Result<PageTitle, List<DomainFailure>> validate(String? title) {
    final failures = <DomainFailure>[];
    
    // Valida que el título no sea nulo.
    if (title == null) {
      failures.add(PageInvalidTitleFailure(
        details: 'Title cannot be null.',
      ));
      return Result.failure(failures);
    }
    
    // Corta los espacios en blanco al principio y al final de la cadena de entrada.
    final trimmedTitle = title.trim();
    
    // Valida que el título no esté vacío.
    if (trimmedTitle.isEmpty) {
      failures.add(PageInvalidTitleFailure(
        details: 'Title cannot be empty.',
      ));
      
    }
    
    // Valida que el título no exceda la longitud máxima.
    if(trimmedTitle.length > NotebookConstants.maxPageTitleLength) {
      failures.add(PageTitleTooLongFailure(
        details: 'Actual Length: ${trimmedTitle.length}, Max Length: ${NotebookConstants.maxNotebookNameLength}.',
      ));
    }
    
    // Valida que el título contenga solo caracteres permitidos.
    if(_isValidTitle(trimmedTitle) == false) {
      final invalidChars = _getInvalidCharacters(trimmedTitle);
      
      failures.add(PageInvalidTitleFailure(
        details: 'Title contains invalid characters: ${invalidChars.join(', ')}.'
      ));
    }
    
    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el título de la página como un éxito.
    return Result.success(PageTitle._(trimmedTitle));
  }
  
  /// TitleRegExp: Permite nombres de páginas seguros y expresivos:
  /// - Letras (incluye acentos y caracteres internacionales).
  /// - Números.
  /// - Espacios y caracteres comunes: espacio, punto, coma, guion, paréntesis, signos de exclamación, etc.
  /// - Excluye caracteres peligrosos para bases de datos: comillas, %, \, <, >, ;, =, etc.
  /// - Usa bandera 'unicode: true' para soportar caracteres multilenguaje correctamente.
  static final _titleRegExp = RegExp(r"^[\p{L}\p{N} .,!?\-()&@#]+$", unicode: true);
  
  /// ValidCharRegExp permite lo mismo que TitleRegExp pero carcater por carácter.
  static final _validCharRegExp = RegExp(r"[\p{L}\p{N} .,!?\-()&@#]", unicode: true);
  
  static _isValidTitle(String title) {
    return _titleRegExp.hasMatch(title);
  }
  
    static Set<String> _getInvalidCharacters(String title) {
    final invalidChars = <String>{};
    
    for(var i = 0; i < title.length; i++) {
      final char = title[i];
      if(_validCharRegExp.hasMatch(char) == false) {
        invalidChars.add(char);
      }
    }
    return invalidChars;
  }
}
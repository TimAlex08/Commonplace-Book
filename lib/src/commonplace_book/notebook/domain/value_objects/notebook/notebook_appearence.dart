// Failures / Result
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// NotebookAppearence: Objeto de valor que representa la apariencia de un `Notebook`.
/// - Valida que color, coverImageUrl y backCoverImageUrl no estén vacíos o nulos.
/// - Valida que el color sea un código hexadecimal válido con formato #AARRGGBB.
class NotebookAppearence {
  const NotebookAppearence._({
    required this.color, 
    required this.coverImagePath, 
    required this.backCoverImagePath
  });
  
  final String color;
  final String coverImagePath;
  final String backCoverImagePath;
  
  static const NotebookAppearence defaultAppearance = NotebookAppearence._(
    color: '#808080',
    coverImagePath: '',
    backCoverImagePath: '',
  );
  
  /// Método que valida `NotebookAppearence` (`Color`, `CoverImageUrl` y `BackCoverImageUrl`).
  static Result<NotebookAppearence, List<DomainFailure>> validate({String? color, String? coverImagePath, String? backCoverImagePath}) {
    final failures = <DomainFailure>[];
    
    // ----- Validaciones de nulabilidad ----- //
    if(color == null || coverImagePath == null || backCoverImagePath == null) {
      if(color == null) {
        failures.add(NotebookInvalidColorFailure(details: 'Color cannot be null.'));
      } 
      if(coverImagePath == null) {
        failures.add(NotebookInvalidCoverImageFailure(details: 'Cover image URL cannot be null.'));
      }
      if(backCoverImagePath == null) {
        failures.add(NotebookInvalidBackCoverImageFailure(details: 'Back cover image URL cannot be null.'));
      }
      
      return Result.failure(failures);
    }

    // Variables formateados.
    final trimmedColor = color.trim();
    final trimmedCoverImageUrl = coverImagePath.trim();
    final trimmedBackCoverImageUrl = backCoverImagePath.trim();
    
    // Valida que el color no esté vacío.
    if(trimmedColor.isEmpty) {
      failures.add(NotebookInvalidColorFailure(details: 'Color cannot be empty.'));
      return Result.failure(failures);
    }
    
    // Valida que el código de color sea correcto.
    if(colorRegex.hasMatch(trimmedColor) == false) {
      // Valida que el color sea un código hexadecimal válido.
      failures.add(NotebookColorFormatFailure(
        details: 'Color must be a valid hex color code with a #RRGGBB format.',
      ));
    }
    
    // Si hay errores, devuelve una lista de fallos
    if (failures.isNotEmpty) {
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el objeto NotebookAppearence como un éxito.
    return Result.success(NotebookAppearence._(
      color: trimmedColor, 
      coverImagePath:  trimmedCoverImageUrl, 
      backCoverImagePath:  trimmedBackCoverImageUrl
    ));   
  }
  
  static final RegExp colorRegex = RegExp(r'^#([A-Fa-f0-9]{2}){3}$');
}
// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



/// NotebookState: Objeto de valor que representa el estado de una libreta.
/// - isFavorite: Indica si la libreta es favorita.
/// - isArchived: Indica si la libreta está archivada.
/// - isLocked: Indica si la libreta está protegida con contraseña.
class NotebookState {
  const NotebookState({
    required this.isFavorite, 
    required this.isArchived, 
    required this.isLocked
  });
  
  final bool isFavorite;
  final bool isArchived;
  final bool isLocked;
  
  static const NotebookState defaultState = NotebookState(
    isFavorite: false,
    isArchived: false,
    isLocked: false,
  );
  
  /// Método que valida `NotebookState` (`isFavorite`, `isArchived` y `isLocked`).
  static Result<NotebookState, List<DomainFailure>> validate({bool? isFavorite, bool? isArchived, bool? isLocked}) {
    final failures = <DomainFailure>[];
    
    // ----- Validaciones de nulabilidad ----- //
    if(isFavorite == null || isArchived == null || isLocked == null) {
      if(isFavorite == null) {
        failures.add(NotebookInvalidFavoriteValueFailure(
          details: 'Favorite value cannot be null.',
        ));
      } 
      if(isArchived == null) {
        failures.add(NotebookInvalidArchivedValueFailure(
          details: 'Archived value cannot be null.',
        ));
      }
      if(isLocked == null) {
        failures.add(NotebookInvalidLockedValueFailure(
          details: 'Locked value cannot be null.',
        ));
      }
      
      return Result.failure(failures);
    }
    
    // Valida que una libreta pueda serr favorita y archivada al mismo tiempo (Estado inválido).
    if(isFavorite == true && isArchived == true) {
      failures.add(NotebookFavoriteAndArchivedConflictFailure(
        details: 'A notebook cannot be both favorite and archived.',
      ));
      return Result.failure(failures);
    }
    
    // Si no hay errores, devuelve el estado de la libreta como un éxito.
    return Result.success(NotebookState(
      isFavorite: isFavorite,
      isArchived: isArchived,
      isLocked: isLocked,
    ));
  }
}
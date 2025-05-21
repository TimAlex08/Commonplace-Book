// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/notebook/notebook_id.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';

// Result
import 'package:commonplace_book/src/shared/core/result.dart';

// Value Objects
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/notebook/notebook_vo.dart';



/// Notebook: Representa la entidad de un cuaderno en la aplicación.
class Notebook {
  const Notebook._({
    required this.id,
    required this.name,
    required this.description,
    required this.timestamp,
    required this.appearence,
    required this.state,
  });
  
  final NotebookId id;
  final NotebookName name;
  final NotebookDescription description;
  final NotebookTimestamp timestamp;
  final NotebookAppearence appearence;
  final NotebookState state;
  
  static Result<Notebook, List<DomainFailure>> create(NotebookParams params) {
    final failures = <DomainFailure>[];
    
    // ----- Validaciones de parametros ----- //
    final idResult = NotebookId.validate(params.id);
    final nameResult = NotebookName.validate(params.name);
    final descriptionResult = NotebookDescription.validate(params.description);
    final timestamtpResult = NotebookTimestamp.validate(params.createdAt, params.updatedAt);
    
    final appearenceResult = NotebookAppearence.validate(
      color: params.color ?? NotebookAppearence.defaultAppearance.color,
      coverImagePath: params.coverImagePath ?? NotebookAppearence.defaultAppearance.coverImagePath,
      backCoverImagePath: params.backCoverImagePath ?? NotebookAppearence.defaultAppearance.backCoverImagePath,
    );
    
    final stateResult = NotebookState.validate(
      isFavorite: params.isFavorite ?? NotebookState.defaultState.isFavorite,
      isArchived: params.isArchived ?? NotebookState.defaultState.isArchived,
      isLocked: params.isLocked ?? NotebookState.defaultState.isLocked,
    );
    
    // ----- Acumular errores si hay fallos en la validaciones ----- //
    if (nameResult.isFailure) failures.addAll(nameResult.getFailure());
    if (descriptionResult.isFailure) failures.addAll(descriptionResult.getFailure());
    if (timestamtpResult.isFailure) failures.addAll(timestamtpResult.getFailure());
    if (appearenceResult.isFailure) failures.addAll(appearenceResult.getFailure());
    if (stateResult.isFailure) failures.addAll(stateResult.getFailure());
    
    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) return Result.failure(failures);
    
    // Si no hay errores, crea un objeto válido Notebook.
    return Result.success(Notebook._(
      id: idResult.getSuccess(),
      name: nameResult.getSuccess(),
      description: descriptionResult.getSuccess(),
      timestamp: timestamtpResult.getSuccess(),
      appearence: appearenceResult.getSuccess(),
      state: stateResult.getSuccess(),
    ));
  }
}



/// NotebookParams: Clase que representa los parámetros necesarios para crear un `Notebook`.
class NotebookParams{
  const NotebookParams({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.coverImagePath,
    this.backCoverImagePath,
    this.isFavorite,
    this.isArchived,
    this.isLocked
  });
  
  final String? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? color;
  final String? coverImagePath;
  final String? backCoverImagePath;
  final bool? isFavorite;
  final bool? isArchived;
  final bool? isLocked;
}
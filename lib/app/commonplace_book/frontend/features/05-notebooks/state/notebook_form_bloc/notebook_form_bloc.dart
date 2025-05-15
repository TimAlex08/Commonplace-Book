import 'package:bloc/bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:equatable/equatable.dart';

part 'notebook_form_event.dart';
part 'notebook_form_state.dart';



class NotebookFormBloc extends Bloc<NotebookFormEvent, NotebookFormState> {
  NotebookFormBloc({NotebookUiModel? initialNotebook}) : super(
    initialNotebook == null
      ? NotebookFormState.create()
      : NotebookFormState.edit(initialNotebook)
  ) {
    // Eventos de cambio de información
    on<NotebookNameChanged>(_onNameChanged);
    on<NotebookDescriptionChanged>(_onDescriptionChanged);
    
    // Eventos de cambios de estilo
    on<NotebookColorChanged>(_onColorChanged);
    on<NotebookCoverImagePathChanged>(_onCoverImageChanged);
    on<NotebookBackCoverImagePathChanged>(_onBackCoverImageChanged);
    
    // Eventos de cambios de estado
    on<NotebookFavoriteToggled>(_onFavoriteToggled);
    on<NotebookArchivedToggled>(_onArchivedToggled);
    on<NotebookLockedToggled>(_onLockedToggled);
    
    // Evento de enviado
    on<NotebookFormSubmitted>(_onNotebookFormSubmitted);
  }
  
  // ---------- Eventos de cambio de información ---------- //
  /// NotebookNameChanged Event Handler
  void _onNameChanged(NotebookNameChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(name: event.name);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }

  /// NotebookDescriptionChanged Event Handler
  void _onDescriptionChanged(NotebookDescriptionChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(description: event.description);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }



  // ---------- Eventos de cambio de estilo ---------- //
  /// NotebookColorChanged Event Handler
  void _onColorChanged(NotebookColorChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(color: event.color);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
  /// NotebookCoverImageChanged Event Handler  
  void _onCoverImageChanged(NotebookCoverImagePathChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(coverImagePath: event.coverImagePath);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
  /// NotebookCoverImageChanged Event Handler  
  void _onBackCoverImageChanged(NotebookBackCoverImagePathChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(backCoverImagePath: event.backCoverImagePath);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
  
  
  // ---------- Eventos de cambio de estilo ---------- //
  /// OnFavoriteToggled Event Handler
  void _onFavoriteToggled(NotebookFavoriteToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(isFavorite: event.isFavorite);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
  /// OnArchivedToggled Event Handler
  void _onArchivedToggled(NotebookArchivedToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(isArchived: event.isArchived);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
    /// OnArchivedToggled Event Handler
  void _onLockedToggled(NotebookLockedToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook.copyWith(isLocked: event.isLocked);
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessages: errors.isEmpty 
        ? null 
        : errors
    ));
  }
  
  void _onNotebookFormSubmitted(
    NotebookFormSubmitted event,
    Emitter<NotebookFormState> emit,
  ) {
    emit(state.copyWith(status: NotebookFormStatus.success));
  }
}




Map<String, List<String>> _validateForm(NotebookUiModel notebook) {
  final name = notebook.name.trim();
  final description = notebook.description.trim();
 
  final errors = <String, List<String>>{};
 
  /// Errores de Nombre
  final nameErrors = <String>[];

  if (name.isEmpty) nameErrors.add('El nombre no puede estar vacío.');
  if (name.length > 100) nameErrors.add('Nombre demasiado largo');
  
  // Solo agregar la clave si hay errores
  if (nameErrors.isNotEmpty) {
    errors['name'] = nameErrors;
  }
 
 
  // Errores de Descripción
  final descriptionErrors = <String>[];
  
  if (description.length > 500) descriptionErrors.add('Descripción demasiado larga');
  
  if (descriptionErrors.isNotEmpty) {
    errors['description'] = descriptionErrors;
  }
 
  return errors;
}
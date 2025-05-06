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
  }
  
  // ---------- Eventos de cambio de información ---------- //
  /// NotebookNameChanged Event Handler
  void _onNameChanged(NotebookNameChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['name'],
    ));
  }

  /// NotebookDescriptionChanged Event Handler
  void _onDescriptionChanged(NotebookDescriptionChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['description']
    ));
  }



  // ---------- Eventos de cambio de estilo ---------- //
  /// NotebookColorChanged Event Handler
  void _onColorChanged(NotebookColorChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['color']
    ));
  }
  
  /// NotebookCoverImageChanged Event Handler  
  void _onCoverImageChanged(NotebookCoverImagePathChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['coverImagePath']
    ));
  }
  
  /// NotebookCoverImageChanged Event Handler  
  void _onBackCoverImageChanged(NotebookBackCoverImagePathChanged event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['backCoverImagePath']
    ));
  }
  
  
  
  // ---------- Eventos de cambio de estilo ---------- //
  /// OnFavoriteToggled Event Handler
  void _onFavoriteToggled(NotebookFavoriteToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['isFavorite']
    ));
  }
  
  /// OnArchivedToggled Event Handler
  void _onArchivedToggled(NotebookArchivedToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['isArchived']
    ));
  }
  
    /// OnArchivedToggled Event Handler
  void _onLockedToggled(NotebookLockedToggled event, Emitter<NotebookFormState> emit) {
    final updatedNotebook = state.notebook;
    final errors = _validateForm(updatedNotebook);
    
    emit(state.copyWith(
      notebook: updatedNotebook,
      isValid: errors.isEmpty,
      errorMessage: errors['isLocked']
    ));
  }
}



Map<String, String> _validateForm(NotebookUiModel notebook) {
  final name = notebook.name.trim();
  final description = notebook.description.trim();
  
  final errors = <String, String>{};
  
  if (name.isEmpty || name.length > 100) {
    errors['name'] = 'El nombre no puede estar vacío y debe tener un máximo de 100 caracteres.';
  }
  
  if (description.length > 500) {
    errors['description'] = 'La descripción no puede tener más de 500 caracteres.';
  }
  
  return errors;
}
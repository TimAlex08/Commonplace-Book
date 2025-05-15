part of 'notebook_form_bloc.dart';

enum NotebookFormStatus { initial, loading, failure, success }

extension NotebookFormStatusX on NotebookFormStatus {
  bool get isLoadingOrSuccess => [
    NotebookFormStatus.loading,
    NotebookFormStatus.success
  ].contains(this);
}

final class NotebookFormState extends Equatable {
  const NotebookFormState({
    required this.notebook,
    this.initialNotebook, 
    this.status = NotebookFormStatus.initial,
    this.isValid = false, 
    this.errorMessages
  });
  
  final NotebookUiModel notebook;
  final NotebookUiModel? initialNotebook;
  final NotebookFormStatus status;
  final bool isValid;
  final Map<String, List<String>>? errorMessages;
  
  bool get isNewNotebook => initialNotebook == null;
  
  NotebookFormState copyWith({
    NotebookFormStatus? status,
    NotebookUiModel? initialNotebook,
    NotebookUiModel? notebook,
    bool? isValid,
    Map<String, List<String>>? errorMessages,
  }) {
    return NotebookFormState(
      status: status ?? this.status,
      initialNotebook: initialNotebook ?? this.initialNotebook,
      notebook: notebook ?? this.notebook,
      isValid: isValid ?? this.isValid,
      errorMessages: errorMessages,
    );
  }
  
  /// NotebookFormState.create: Constructor inicial para creación
  factory NotebookFormState.create() {
    return NotebookFormState(
      notebook: NotebookUiModel.empty(),
      initialNotebook: null,
      isValid: false
    );
  }
  
  /// NotebookFormState.edit: Constructor inicial para edición
  factory NotebookFormState.edit(NotebookUiModel initialNotebook) {
    return NotebookFormState(
      notebook: initialNotebook,
      initialNotebook: initialNotebook,
      isValid: true
    );
  }
  
  @override
  List<Object?> get props => [status, initialNotebook, notebook, isValid, errorMessages];
}
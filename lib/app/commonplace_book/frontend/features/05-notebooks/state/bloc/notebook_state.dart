part of 'notebook_bloc.dart';

enum NotebookStatus { initial, loading, success, failure }

final class NotebookState extends Equatable {
  const NotebookState({
    this.status = NotebookStatus.initial,
    this.notebooks = const <NotebookUiModel>[],
    this.selectedNotebook,
    this.userMessage,
  });
  
  final NotebookStatus status;
  final List<NotebookUiModel> notebooks;
  final NotebookUiModel? selectedNotebook;
  final UserMessage? userMessage;
  
  NotebookState copyWith({
    NotebookStatus? status,
    List<NotebookUiModel>? notebooks,
    NotebookUiModel? selectedNotebook,
    UserMessage? userMessage,
    bool clearSelectedNotebook = false,
  }) {
    return NotebookState(
      status: status ?? this.status,
      notebooks: notebooks ?? this.notebooks,
      userMessage: userMessage ?? this.userMessage,
      selectedNotebook: clearSelectedNotebook
        ? null
        : (selectedNotebook ?? this.selectedNotebook),
    );
  }
  
  @override
  List<Object?> get props => [status, notebooks, selectedNotebook, userMessage];
}

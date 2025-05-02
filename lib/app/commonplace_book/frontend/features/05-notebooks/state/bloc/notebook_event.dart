part of 'notebook_bloc.dart';

sealed class NotebookEvent extends Equatable {
  const NotebookEvent();

  @override
  List<Object> get props => [];
}

// Eventos de comandos
final class CreateNotebook extends NotebookEvent {
  const CreateNotebook(this.notebook);
  final NotebookUiModel notebook;
}

final class UpdateNotebook extends NotebookEvent {
  const UpdateNotebook(this.notebook);
  final NotebookUiModel notebook;
}

final class HardDeleteNotebook extends NotebookEvent {
  const HardDeleteNotebook(this.notebookId);
  final String notebookId;
}

final class ToggleFavoriteNotebook extends NotebookEvent {
  const ToggleFavoriteNotebook(this.notebookId);
  final String notebookId;
}

final class ToggleArchivedNotebook extends NotebookEvent {
  const ToggleArchivedNotebook(this.notebookId);
  final String notebookId;
}

final class ToggleLockedNotebook extends NotebookEvent {
  const ToggleLockedNotebook(this.notebookId);
  final String notebookId;
}



// Eventos de consulta
final class LoadAllNotebooks extends NotebookEvent {}

final class LoadNotebookById extends NotebookEvent {
  const LoadNotebookById(this.notebookId);
  final String notebookId;
}



// Eventos de observadores
final class WatchAllNotebooks extends NotebookEvent {}

final class WatchNotebookById extends NotebookEvent {
  const WatchNotebookById(this.notebookId);
  final String notebookId;
}



final class NotebooksUpdated extends NotebookEvent {
  const NotebooksUpdated(this.notebooks);
  final List<NotebookUiModel> notebooks;
}

final class SelectedNotebookUpdated extends NotebookEvent {
  const SelectedNotebookUpdated(this.notebook);
  final NotebookUiModel notebook;
}


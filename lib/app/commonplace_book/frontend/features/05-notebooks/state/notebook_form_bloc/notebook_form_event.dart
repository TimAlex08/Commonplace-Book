part of 'notebook_form_bloc.dart';

sealed class NotebookFormEvent extends Equatable {
  const NotebookFormEvent();

  @override
  List<Object> get props => [];
}



// ---------- Eventos cambios de información ---------- //
final class NotebookNameChanged extends NotebookFormEvent {
  const NotebookNameChanged(this.name);
  final String name;
  
  @override
  List<Object> get props => [name];
}

final class NotebookDescriptionChanged extends NotebookFormEvent {
  const NotebookDescriptionChanged(this.description);
  final String description;
  
  @override
  List<Object> get props => [description];
}



// ---------- Eventos cambios de estilo ---------- //
final class NotebookColorChanged extends NotebookFormEvent {
  const NotebookColorChanged(this.color);
  final String color;
  
  @override
  List<Object> get props => [color];
}

final class NotebookCoverImagePathChanged extends NotebookFormEvent{
  const NotebookCoverImagePathChanged(this.coverImagePath);
  final String coverImagePath;
  
  @override
  List<Object> get props => [coverImagePath];
}

final class NotebookBackCoverImagePathChanged extends NotebookFormEvent{
  const NotebookBackCoverImagePathChanged(this.backCoverImagePath);
  final String backCoverImagePath;
  
  @override
  List<Object> get props => [backCoverImagePath];
}



// ---------- Eventos cambios de estado ---------- //
final class NotebookFavoriteToggled extends NotebookFormEvent {
  const NotebookFavoriteToggled(this.isFavorite);
  final bool isFavorite;
  
  @override
  List<Object> get props => [isFavorite];
}

final class NotebookArchivedToggled extends NotebookFormEvent {
  const NotebookArchivedToggled(this.isArchived);
  final bool isArchived;
  
  @override
  List<Object> get props => [isArchived];
}

final class NotebookLockedToggled extends NotebookFormEvent {
  const NotebookLockedToggled(this.isLocked);
  final bool isLocked;
  
  @override
  List<Object> get props => [isLocked];
}



final class NotebookSubmitted extends NotebookFormEvent {
  const NotebookSubmitted();
}
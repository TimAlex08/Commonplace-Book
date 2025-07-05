part of 'structure_bloc.dart';

sealed class StructureEvent extends Equatable {
  const StructureEvent();

  @override
  List<Object> get props => [];
}



// ---------- Eventos de comandos ---------- //
final class CreateStructure extends StructureEvent {
  const CreateStructure(this.structureFormModel);
  final StructureFormModel structureFormModel;
  
  @override
  List<Object> get props => [structureFormModel];
}



// ---------- Eventos de consulta ---------- //
final class LoadNotebookStructure extends StructureEvent {
  const LoadNotebookStructure(this.notebookId);
  final String notebookId;
  
  @override
  List<Object> get props => [notebookId];
}



// ---------- Eventos de observadores ---------- //
final class WatchNotebookStructure extends StructureEvent {
  const WatchNotebookStructure(this.notebookId);
  final String notebookId;
  
  @override
  List<Object> get props => [];
}



// ---------- Eventos de actualización ---------- //
final class StructuresUpdated extends StructureEvent {
  const StructuresUpdated(this.structures);
  final List<StructureUiModel> structures;

  @override
  List<Object> get props => [structures];
}
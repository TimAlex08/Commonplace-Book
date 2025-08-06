part of 'structure_bloc.dart';

abstract class StructureEvent extends Equatable {
  const StructureEvent();

  @override
  List<Object?> get props => [];
}



// ---------- Eventos de estructura (Comandos) ---------- //
// Evento para crear un elemento nuevo (carpeta o página).
final class CreateStructure extends StructureEvent {
  const CreateStructure(this.structureFormModel);
  final StructureFormModel structureFormModel;
  
  @override
  List<Object?> get props => [structureFormModel];
}

// Evento para actualizar un elemento existente.
final class UpdateStructure extends StructureEvent {
  const UpdateStructure({
    required this.structureId,
    required this.newTitle
  });
  
  final String structureId;
  final String newTitle;
  
  @override
  List<Object?> get props => [structureId, newTitle];
}

// Evento para eliminar un elemento.
final class DeleteStructure extends StructureEvent {
  const DeleteStructure(this.structureId);
  final String structureId;
  
  @override
  List<Object?> get props => [structureId];
}

// Evento para reordenar un elemento (cambiar su padre y/o posición)
class ReorderItem extends StructureEvent {
  final String draggedItemId; // ID del elemento que fue arrastrado
  final String? newParentId; // ID de la nueva carpeta padre (null si es raíz)
  final int newPosition; // Nueva posición dentro de la lista de hermanos

  const ReorderItem({
    required this.draggedItemId,
    this.newParentId,
    required this.newPosition,
  });

  @override
  List<Object?> get props => [draggedItemId, newParentId, newPosition];
}



// ---------- Eventos de consulta y observadores ---------- //
// Evento para cargar la estructura inicial o refrescarla.
final class LoadNotebookStructure extends StructureEvent {
  const LoadNotebookStructure(this.notebookId);
  final String notebookId;
  
  @override
  List<Object?> get props => [notebookId];
}

// Evento para iniciar la observación de la estructura (disparado internamente por LoadNotebookStructure).
final class WatchNotebookStructure extends StructureEvent {
  const WatchNotebookStructure(this.notebookId);
  final String notebookId;
  
  @override
  List<Object?> get props => [];
}

// Evento disparado cuando la base de datos emite una actualización.
final class StructuresUpdated extends StructureEvent {
  const StructuresUpdated(this.structures);
  final List<StructureUiModel> structures;

  @override
  List<Object?> get props => [structures];
}



// ---------- Eventos de vista de árbol ---------- //
// Evento para alternar el modo de reordenamiento (arrastrar y soltar)
class ToggleReorderMode extends StructureEvent {
  const ToggleReorderMode();
}

// Evento para alternar la expansión/colapso de una carpeta
class ToggleExpansion extends StructureEvent {
  final String nodeId; // El ID del nodo (carpeta) a expandir/colapsa.
  const ToggleExpansion(this.nodeId);

  @override
  List<Object?> get props => [nodeId];
}
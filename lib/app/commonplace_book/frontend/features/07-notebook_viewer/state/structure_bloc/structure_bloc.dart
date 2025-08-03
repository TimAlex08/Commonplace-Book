// External Imports
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_node_builder.dart';
import 'package:equatable/equatable.dart';

// Internal Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/error_handling/user_error_mapper.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/structure_manager_adapter.dart';

part 'structure_event.dart';
part 'structure_state.dart';

class StructureBloc extends Bloc<StructureEvent, StructureState> {
  final StructureManagerAdapter _structureAdapter;
  StreamSubscription<List<StructureUiModel>>? _structureSubscription;
  
  StructureBloc(this._structureAdapter, {required String notebookId}) : super(StructureState(notebookId: notebookId)) {
    // ---------- Eventos de estructura (comandos) ---------- //
    on<CreateStructure>(_onCreateStructure);
    on<ReorderItem>(_onReorderItem);
    
    // ---------- Eventos de consulta y observadores ---------- //
    on<LoadNotebookStructure>(_onLoadNotebookStructure);
    on<WatchNotebookStructure>(_onWatchNotebookStructure);
    on<StructuresUpdated>(_onStructureUpdated);
    
    // ---------- Eventos de vista de árbol ---------- //
    on<ToggleReorderMode>(_onToggleReorderMode);
    on<ToggleExpansion>(_onToggleExpansion);
  }
  
  // ---------- Eventos de estructura (comandos) ---------- //
  Future<void> _onCreateStructure(CreateStructure event, Emitter<StructureState> emit) async {
    emit(state.copyWith(status: StructureStatus.loading));
    final structureUiModel = event.structureFormModel.structureUiModel;
    final title = event.structureFormModel.title;
    final type = event.structureFormModel.type.name;
    
    final result = await _structureAdapter.createStructureItem(
      structureUiModel: structureUiModel,
      title: title,
      type: type,
    );
    
    result.fold(
      (success) {
        final message = UserMessageMapper.mapSuccess('create');
        emit(state.copyWith(
          status: StructureStatus.success,
          userMessage: message,
        ));
      },
      (failures) {
        final message = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: StructureStatus.failure,
          userMessage: message,
        ));
      },
    );
  }
  
  // OnReorderItem Event Handler: Maneja el evento de reordenamiento de un ítem.
  Future<void> _onReorderItem(ReorderItem event, Emitter<StructureState> emit) async {
    emit(state.copyWith(status: StructureStatus.loading));
    
    final notebookId = state.notebookId;
    final draggedItemId = event.draggedItemId;
    final newParentId = event.newParentId;
    final newPosition = event.newPosition;
    
    final result = await _structureAdapter.reorderStructureItem(
      notebookId: notebookId,
      draggedItemId: draggedItemId,
      newParentId: newParentId,
      newPosition: newPosition
    );
    
    result.fold(
      (rowsAffected) {
        final message = UserMessageMapper.mapSuccess('reorder');
        emit(state.copyWith(
          status: StructureStatus.success,
          userMessage: message
        ));
      },
      (failures) {
        final message = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: StructureStatus.failure,
          userMessage: message,
        ));
      }
    );
  }
  
  
  
  // ---------- Eventos de consulta y observadores ---------- //
  // OnLoadNotebookStructure Event Handler: Este evento se encarga de cargar la estructura de una libreta.
  // Su propósito es iniciar el proceso de carga de datos y potencialmente indicar un estado de carga a la UI.
  // No se encarga de la expansión inicial de los nodos; esto ocurre cuando los datos son recibidos y procesados.
  // _onStructureUpdates hara el resto.
  Future<void> _onLoadNotebookStructure(LoadNotebookStructure event, Emitter<StructureState> emit) async {
    emit(state.copyWith(status: StructureStatus.loading));
    final notebookId = event.notebookId;
    
    final result = await _structureAdapter.getNotebookStructures(notebookId: notebookId);
    
    result.fold(
      (structures) {
        emit(state.copyWith(
          status: StructureStatus.success,
          rawStructures: structures,
        ));
      },
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: StructureStatus.failure,
          userMessage: userErrorMessage
        ));
      },
    );
  }
  
  // OnWatchNotebookStructure Event Handler: Inicia la observación de la estructura de una libreta.
  void _onWatchNotebookStructure(WatchNotebookStructure event, Emitter<StructureState> emit) {
    final notebookId = event.notebookId;
    _structureSubscription?.cancel();
    
    // Obtener el stream de la estructura de la libreta.
    final notebookStructureStream = _structureAdapter.watchNotebookStructure(notebookId);
    
    // Crear la suscripción.
    _structureSubscription = notebookStructureStream.listen((structure) {
      add(StructuresUpdated(structure));
    });
  }
  
  // OnStructureUpdated Event Handler: Maneja las actualizaciones de la estructura recibidas del stream.
  // Este es el punto central de la lista plana de datos `rawStructures`, se convierte en la estructura
  // de árbol `treeNodes` que la UI renderiza.
  void _onStructureUpdated(StructuresUpdated event, Emitter<StructureState> emit) {
    final rawStructures = event.structures;
    final Map<String, bool> currentExpandedNodes = Map<String, bool>.from(state.expandedNodes);
    
    // Lógica para inicializar o actualizar el mapa expandedNodes.
    if(state.status == StructureStatus.initial || currentExpandedNodes.isEmpty) {
    // Primera carga: colapsar todas las carpetas por defectos.
      for(final s in rawStructures) {
        currentExpandedNodes[s.structureId!] = false;
      }
    } else {
      // Si no es primera carga, mantener expansiones existentes y añadir nuevas carpetas colapsadas.
      final Set<String> existingIds = rawStructures.map((s) => s.structureId!).toSet();
      final Map<String, bool> newExpandedNodes = {};
      
      for(final entry in currentExpandedNodes.entries) {
        if(existingIds.contains(entry.key)) {
          newExpandedNodes[entry.key] = entry.value; // Mantener estado de expansión
        }
      }
      
      for(final s in rawStructures) {
        if(s.type == 'folder' && !newExpandedNodes.containsKey(s.structureId!)) {
          newExpandedNodes[s.structureId!] = false;
        }
      }
      
      currentExpandedNodes.clear();
      currentExpandedNodes.addAll(newExpandedNodes);
    }
    
    // Construir la estructura de árbol usando los datos y el estado de expansión.
    final treeNodes = TreeNodeBuilder.buildTreeNodes(rawStructures, currentExpandedNodes);
    
    emit(state.copyWith(
      rawStructures: event.structures,
      treeNodes: treeNodes,
      expandedNodes: currentExpandedNodes,
      status: StructureStatus.success,
    ));
  }
  
  
  
  // ---------- Manejadores de eventos de UI ---------- //
  // OnToggleReorderMode: Habilita o deshabilita el modo de reordenamiento.
  // Invierte el valor de isReorderMode en el estado de BLoC.
  // Esto le indica a la UI debe mostrar los "drag handler" y habilidar el drag and drop.
  void _onToggleReorderMode(ToggleReorderMode event, Emitter<StructureState> emit) {
    emit(state.copyWith(isReorderMode: !state.isReorderMode));
  }
  
  // OnTogleNodeExpansion: Alterna la expansión de un nodo específico.
  void _onToggleExpansion(ToggleExpansion event, Emitter<StructureState> emit) {
    final nodeId = event.nodeId;
    final currentExpandedNodes = Map<String, bool>.from(state.expandedNodes);
    
    if(currentExpandedNodes.containsKey(nodeId)) {
      currentExpandedNodes[nodeId] = !currentExpandedNodes[nodeId]!;
    } else {
      currentExpandedNodes[nodeId] = true;
    }
    
    // Reconstruir el árbol inmediantamente con el estado de expansión.
    final treeNodes = TreeNodeBuilder.buildTreeNodes(state.rawStructures, currentExpandedNodes);
    
    emit(state.copyWith(
      expandedNodes: currentExpandedNodes,
      treeNodes: treeNodes,
    ));
  }
  
  @override
  Future<void> close() {
    _structureSubscription?.cancel();
    return super.close();
  }
}
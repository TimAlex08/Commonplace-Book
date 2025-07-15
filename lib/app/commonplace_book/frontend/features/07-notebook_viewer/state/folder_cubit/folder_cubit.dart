import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/structure_bloc/structure_bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:equatable/equatable.dart';

part 'folder_state.dart';

class FolderCubit extends Cubit<FolderState> {
  final StructureBloc structureBloc;
  StreamSubscription<StructureState>? _structureSubscription;
  
  FolderCubit(this.structureBloc) : super(FolderState()) {
    // Escuchar cambios en el StructureBloc
    _structureSubscription = structureBloc.stream.listen(_onStructureStateChanged);
    
    // Verificar el estado inicial
    _onStructureStateChanged(structureBloc.state);
  }
  
  List<StructureUiModel> _allStructures = [];
  
    void _onStructureStateChanged(StructureState structureState) {
    // Manejar diferentes estados del StructureBloc basado en tu enum
    switch (structureState.status) {
      case StructureStatus.success:
        _allStructures = structureState.structures;
        _updateVisibleStructures();
        break;
      case StructureStatus.loading:
        // Opcional: mantener la lista actual o limpiarla
        // _allStructures = [];
        // _updateVisibleStructures();
        break;
      case StructureStatus.initial:
      case StructureStatus.failure:
        // Opcional: limpiar la lista en caso de error
        // _allStructures = [];
        // _updateVisibleStructures();
        break;
    }
  }
  
  // ---------- Event Handlers ---------- //
  // SetAllStructures Handler Event: Establece todas las estructuras y actualiza las visibles.
  void setAllStructures(List<StructureUiModel> structures) {
    _allStructures = structures;
    _updateVisibleStructures();
  }
  
  // ToggleFolder Handler Event: Alterna el estado de expansión de una carpeta.
  void toggleFolder(String folderId) {
    final newExpandedFolders = Map<String, bool>.from(state.expandedFolders);
    newExpandedFolders[folderId] = !(newExpandedFolders[folderId] ?? false);
    
    emit(state.copyWith(expandedFolders: newExpandedFolders));
    _updateVisibleStructures();
  }
  
  // ExpandFolder Hanlder Event: Expande una carpeta específica si no está expandida.
  void expandFolder(String folderId) {
    if(state.expandedFolders[folderId] != true) {
      final newExpandedFolders = Map<String, bool>.from(state.expandedFolders);
      newExpandedFolders[folderId] = true;
      
      emit(state.copyWith(expandedFolders: newExpandedFolders));
      _updateVisibleStructures();
    }
  }
  
  // CollapseFolder Handler Event: Colapsa una carpeta específica si está expandida.
  void collapseFolder(String folderId) {
    if(state.expandedFolders[folderId] != false) {
      final newExpandFolders = Map<String, bool>.from(state.expandedFolders);
      newExpandFolders[folderId] = false;
      
      emit(state.copyWith(expandedFolders: newExpandFolders));
      _updateVisibleStructures();
    }
  }
  
  // ExpandAllFolders Event Handler: Expande todas las carpetas.
  void expandAllFolders() {
    final newExpandedFolders = <String, bool>{};
    for (var structure in _allStructures) {
      if (structure.type == 'folder' && structure.folderId != null) {
        newExpandedFolders[structure.folderId!] = true;
      }
    }
    
    emit(state.copyWith(expandedFolders: newExpandedFolders));
    _updateVisibleStructures();
  }

  // CollapseAllFolders Event Handler: Colapsa todas las carpetas.
  void collapseAllFolders() {
    emit(state.copyWith(expandedFolders: const {}));
    _updateVisibleStructures();
  }
  
  // UpdateVisibleStructures Handler Event: Actualiza las estructuras visibles.
  void _updateVisibleStructures() {
    final visibleStructures = _getVisibleStructures();
    emit(state.copyWith(visibleStructures: visibleStructures));
  }
  
  
  
  // ---------- Helper Methods ---------- //
  /// GetVisibleStructures: Obtiene las estructuras visibles basadas en el estado actual de expansión de las carpetas.
  List<StructureUiModel> _getVisibleStructures() {
    if(_allStructures.isEmpty) return [];
    
    List<StructureUiModel> visibleItems = [];
    
    // Crear mapa para acceso rápido a elementos padre
    Map<String, StructureUiModel> structureById = {};
    for (var structure in _allStructures) {
      if (structure.type == 'folder' && structure.folderId != null) {
        structureById[structure.folderId!] = structure;
      } else if (structure.type == 'page' && structure.pageId != null) {
        structureById[structure.pageId!] = structure;
      }
    }
     
    bool areAllAncestorsExpanded(StructureUiModel item) {
      if (item.depth == 0) return true; // Elementos raíz siempre visibles
      
      if (item.parentId == null) return true;
      
      // Encontrar el elemento padre
      StructureUiModel? parent = structureById[item.parentId!];
      if (parent == null) return false;
      
      // Si el padre es una carpeta, verificar si está expandida
      if (parent.type == 'folder' && parent.folderId != null) {
        if (!(state.expandedFolders[parent.folderId!] ?? false)) {
          return false;
        }
      }
      
      // Verificar recursivamente todos los ancestros
      return areAllAncestorsExpanded(parent);
    }

    // Filtrar elementos visibles manteniendo el orden original
    for (var structure in _allStructures) {
      if (areAllAncestorsExpanded(structure)) {
        visibleItems.add(structure);
      }
    }

    return visibleItems;
  }
  
  /// IsFolderExpanded: Verifica si una carpeta está expandida.
  bool isFolderExpanded(String folderId) {
    return state.expandedFolders[folderId] ?? false;
  }
  
  // Método para obtener el número de elementos hijos de una carpeta
  int getChildrenCount(String folderId) {
    return _allStructures.where((item) => item.parentId == folderId).length;
  }

  // Método para verificar si una carpeta tiene elementos hijos
  bool hasChildren(String folderId) {
    return _allStructures.any((item) => item.parentId == folderId);
  }
  
  
  
  // ---------- StreamSuscription Close ---------- //
  @override
  Future<void> close() {
    _structureSubscription?.cancel();
    return super.close();
  }
}
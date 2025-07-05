// External Imports
import 'dart:async';

import 'package:bloc/bloc.dart';
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
    on<CreateStructure>(_onCreateStructure);
    on<LoadNotebookStructure>(_onLoadNotebookStructure);
    on<WatchNotebookStructure>(_onWatchNotebookStructure);
    on<StructuresUpdated>(_onStructureUpdated);
  }
  
  // ---------- Eventos de comandos ---------- //
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
        final message = UserErrorMapper.mapSuccess('create');
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
  
  
  
  // ---------- Eventos de consulta ---------- //
  // OnLoadNotebookStructure Event Handler.
  Future<void> _onLoadNotebookStructure(LoadNotebookStructure event, Emitter<StructureState> emit) async {
    emit(state.copyWith(status: StructureStatus.loading));
    final notebookId = event.notebookId;
    
    final result = await _structureAdapter.getNotebookStructures(notebookId: notebookId);
    
    result.fold(
      (structures) {
        emit(state.copyWith(
          status: StructureStatus.success,
          structures: structures,
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
  
  
  
  // ---------- Eventos de observadores ---------- //
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
  
  
  
  // ---------- Eventos de actualización ---------- //
  void _onStructureUpdated(StructuresUpdated event, Emitter<StructureState> emit) {
    emit(state.copyWith(
      structures: event.structures,
      status: StructureStatus.success,
    ));
  }
  
  @override
  Future<void> close() {
    _structureSubscription?.cancel();
    return super.close();
  }
}
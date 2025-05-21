import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/error_handling/user_error_mapper.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/dto/notebook_dto.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';
import 'package:equatable/equatable.dart';

import '../../../shared/models/models.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';

class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  final ForManagingNotebooksPort _notebookPort;
  StreamSubscription<List<NotebookDTO>>? _notebookSubscription;
  StreamSubscription<NotebookDTO>? _selectedNotebookSubscription;
  
  NotebookBloc(this._notebookPort) : super(NotebookState()) {
    // Eventos de comandos
    on<CreateNotebook>(_onCreateNotebook);
    on<UpdateNotebook>(_onUpdateNotebook);
    on<HardDeleteNotebook>(_onHardDeleteNotebook);
    
    // Eventos de consulta
    on<LoadAllNotebooks>(_onLoadAllNotebooks);
    on<LoadNotebookById>(_onLoadNotebookById);
    
    // Eventos de observadores
    on<WatchAllNotebooks>(_onWatchAllNotebooks);
    on<WatchNotebookById>(_onWatchNotebookById);
    
    // Eventos de actualización
    on<NotebooksUpdated>(_onNotebooksUpdated);
    on<SelectedNotebookUpdated>(_onSelectedNotebookUpdated);
  }
  
  // ---------- Eventos de Comandos ---------- //
  // OnCreateNotebook Event Handler
  Future<void> _onCreateNotebook(CreateNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookPort.command.createNotebook(event.notebook.toDto());
    
    result.fold(
      (rowId) {
        final userMessage = UserErrorMapper.mapSuccess('create');
        emit(state.copyWith(
          status: NotebookStatus.success,
          userMessage: userMessage
        ));
      },
      
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          userMessage: userErrorMessage
        ));
      } 
    );
  }
  
  // OnUpdateNotebook Event Handler
  Future<void> _onUpdateNotebook(UpdateNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookPort.command.updateNotebook(event.notebook.toDto());
    
    result.fold(
      (rowId) {
        final userMessage = UserErrorMapper.mapSuccess('update');
        emit(state.copyWith(
          status: NotebookStatus.success,
          userMessage: userMessage
        ));
      },
      
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          userMessage: userErrorMessage
        ));
      }
    );
  }
  
  // OnHardDeleteNotebook Event Handler
  Future<void> _onHardDeleteNotebook(HardDeleteNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookPort.command.hardDeleteNotebook(event.notebookId);
    
    result.fold(
      (rowId) {
        final userMessage = UserErrorMapper.mapSuccess('delete');
        emit(state.copyWith(
          status: NotebookStatus.success,
          userMessage: userMessage,
          clearSelectedNotebook: state.selectedNotebook?.id == event.notebookId
        ));
      },
      
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          userMessage: userErrorMessage
        ));
      }
    );
  }
  
  
  
  // ---------- Eventos de consultas ---------- //
  // OnLoadAllNotebooks Event Handler
  Future<void> _onLoadAllNotebooks(LoadAllNotebooks event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookPort.query.getAllNotebooks();
    
    result.fold(
      (allNotebooksDto) {
        final notebooks = allNotebooksDto.map((dto) => NotebookUiModel.fromDto(dto)).toList(); 
        emit(state.copyWith(
          status: NotebookStatus.success,
          notebooks: notebooks
        ));
      },
       
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          userMessage: userErrorMessage
        ));
      }
    );
  }
  
  // OnLoadNotebookById 
  Future<void> _onLoadNotebookById(LoadNotebookById event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookPort.query.getNotebookById(event.notebookId);
      
    result.fold(
      (notebookDto) {
        final notebook = NotebookUiModel.fromDto(notebookDto);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          selectedNotebook: notebook
        ));
      },
      
      (failures) {
        final userErrorMessage = UserErrorMapper.mapList(failures);
        emit(state.copyWith(
          status: NotebookStatus.failure,
          userMessage: userErrorMessage
        ));
      }
    );
  }
  
  
  
  // ---------- Eventos de observadores ---------- //
  // OnWatchAllNotebooks Event Handler
  void _onWatchAllNotebooks(WatchAllNotebooks event, Emitter<NotebookState> emit) {
    _notebookSubscription?.cancel();
    
    // Obtener el stream de libretas
    final allNotebookStream = _notebookPort.observer.watchAllNotebooks();
    
    // Crear la suscripción con un callback más simple
    _notebookSubscription = allNotebookStream.listen((notebookListDto) {
      final notebooks = notebookListDto.map((dto) => NotebookUiModel.fromDto(dto)).toList();
      
      add(NotebooksUpdated(notebooks));
    });
  }
  
  void _onWatchNotebookById(WatchNotebookById event, Emitter<NotebookState> emit) {
    _selectedNotebookSubscription?.cancel();
    
    // Obtener el stream de la libreta seleccionada
    final notebookStream = _notebookPort.observer.watchNotebookById(event.notebookId);
    
    _selectedNotebookSubscription = notebookStream.listen((notebookDto) {
      final notebook = NotebookUiModel.fromDto(notebookDto);
      
      add(SelectedNotebookUpdated(notebook));
    });
  }
  
  
  
  // ---------- Eventos de actualización ---------- //
  void _onNotebooksUpdated(NotebooksUpdated event, Emitter<NotebookState> emit) {
    emit(state.copyWith(
      notebooks: event.notebooks,
      status: NotebookStatus.success
    ));
  }
  
  void _onSelectedNotebookUpdated(SelectedNotebookUpdated event, Emitter<NotebookState> emit) {
    emit(state.copyWith(
      selectedNotebook: event.notebook,
      status: NotebookStatus.success
    ));
  }
  
  @override
  Future<void> close() {
    _notebookSubscription?.cancel();
    _selectedNotebookSubscription?.cancel();
    return super.close();
  }
}
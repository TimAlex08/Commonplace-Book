// Dart Imports.
import 'dart:async';

// External Imports.
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Internal Imports.
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/error_handling/user_error_mapper.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/notebook_manager_adapter.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';



class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  final NotebookManagerAdapter _notebookAdapter;
  StreamSubscription<List<NotebookUiModel>>? _notebookSubscription;
  StreamSubscription<NotebookUiModel>? _selectedNotebookSubscription;
  
  NotebookBloc(this._notebookAdapter) : super(NotebookState()) {
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
  
  // ---------- Eventos de comandos ---------- //
  // OnCreateNotebook Event Handler.
  Future<void> _onCreateNotebook(CreateNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookAdapter.createNotebook(event.notebook);
    
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
  
  // OnUpdateNotebook Event Handler.
  Future<void> _onUpdateNotebook(UpdateNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookAdapter.updateNotebook(event.notebook);
    
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
  
  // OnHardDeleteNotebook Event Handler.
  Future<void> _onHardDeleteNotebook(HardDeleteNotebook event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookAdapter.hardDeleteNotebook(event.notebookId);
    
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
  // OnLoadAllNotebooks Event Handler.
  Future<void> _onLoadAllNotebooks(LoadAllNotebooks event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookAdapter.getAllNotebooks();
    
    result.fold(
      (allNotebooksDto) {
        emit(state.copyWith(
          status: NotebookStatus.success,
          notebooks: allNotebooksDto
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
  
  // OnLoadNotebookById.
  Future<void> _onLoadNotebookById(LoadNotebookById event, Emitter<NotebookState> emit) async {
    emit(state.copyWith(status: NotebookStatus.loading));
    
    final result = await _notebookAdapter.getNotebookById(event.notebookId);
      
    result.fold(
      (notebookDto) {
        emit(state.copyWith(
          status: NotebookStatus.failure,
          selectedNotebook: notebookDto
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
  // OnWatchAllNotebooks Event Handler.
  void _onWatchAllNotebooks(WatchAllNotebooks event, Emitter<NotebookState> emit) {
    _notebookSubscription?.cancel();
    
    // Obtener el stream de libretas.
    final allNotebookStream = _notebookAdapter.watchAllNotebooks();
    
    // Crear la suscripción.
    _notebookSubscription = allNotebookStream.listen((notebooks) {
      add(NotebooksUpdated(notebooks));
    });
  }
  
  void _onWatchNotebookById(WatchNotebookById event, Emitter<NotebookState> emit) {
    _selectedNotebookSubscription?.cancel();
    
    // Obtener el stream de la libreta seleccionada.
    final notebookStream = _notebookAdapter.watchNotebookById(event.notebookId);
    
    _selectedNotebookSubscription = notebookStream.listen((notebook) {
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
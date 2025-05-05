// Dart Imports
import 'dart:developer';

// External Imports
import 'package:get_it/get_it.dart';

// Internal Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/notebook_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persiting_notebooks_port.dart';

// UseCases
import '../src/commonplace_book/notebook/application/notebook/commands/create_notebook_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/commands/hard_delete_notebook_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/commands/update_notebook_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/observers/watch_all_notebooks_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/observers/watch_notebook_by_id_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/queries/get_all_notebooks_usecase.dart';
import '../src/commonplace_book/notebook/application/notebook/queries/get_notebook_by_id_usecase.dart';
import '../src/commonplace_book/notebook/infrastructure/adapters/drivers/notebook_manager_adapter.dart';
import '../src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks.dart';

// Blocs
import 'commonplace_book/frontend/features/05-notebooks/state/notebook_bloc/notebook_bloc.dart';



final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  try {
   await _setupExternalDependencies();
   await _setupBlocs();
  } catch (e) {
    log('Error setting up dependencies: $e');
    rethrow;
  }
}

Future<void> _setupExternalDependencies() async {
  getIt.registerLazySingleton(() => AppDatabase()); 
  
  getIt.registerLazySingleton<ForPersitingNotebooksPort>(
    () => NotebookDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso (Commands)
  getIt.registerLazySingleton(() => CreateNotebookUseCase(getIt<ForPersitingNotebooksPort>()));
  getIt.registerLazySingleton(() => UpdateNotebookUsecase(getIt<ForPersitingNotebooksPort>()));
  getIt.registerLazySingleton(() => HardDeleteNotebookUsecase(getIt<ForPersitingNotebooksPort>()));
  
  // Casos de uso (Queries)
  getIt.registerLazySingleton(() => GetAllNotebooksUsecase(getIt<ForPersitingNotebooksPort>()));
  getIt.registerLazySingleton(() => GetNotebookByIdUseCase(getIt<ForPersitingNotebooksPort>()));
  
  // Casos de uso (Observers)
  getIt.registerLazySingleton(() => WatchAllNotebooksUsecase(getIt<ForPersitingNotebooksPort>()));
  getIt.registerLazySingleton(() => WatchNotebookByIdUsecase(getIt<ForPersitingNotebooksPort>()));
  
  // Adaptador de gestión de Notebooks UI (Driver Port) 
    getIt.registerLazySingleton<ForManagingNotebooks>(() => NotebookManagerAdapter(
    createNotebook: getIt<CreateNotebookUseCase>(),
    updateNotebook: getIt<UpdateNotebookUsecase>(),
    hardDeleteNotebook: getIt<HardDeleteNotebookUsecase>(),
    getAllNotebooks: getIt<GetAllNotebooksUsecase>(),
    getNotebookById: getIt<GetNotebookByIdUseCase>(),
    watchAllNotebooks: getIt<WatchAllNotebooksUsecase>(),
    watchNotebookById: getIt<WatchNotebookByIdUsecase>(),
  ));
}

Future<void> _setupBlocs() async {
  // Crear la instancia del NotebookBloc
  final notebookBloc = NotebookBloc(getIt<ForManagingNotebooks>());
  
  // Cargar datos y comenzar observación
  notebookBloc.add(LoadAllNotebooks());
  notebookBloc.add(WatchAllNotebooks());
  
  // Registrar el NotebookBloc como Factory (nueva instancia cada vez)
  getIt.registerSingleton<NotebookBloc>(notebookBloc);
}
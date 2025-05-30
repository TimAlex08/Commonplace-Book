// Dart Imports
import 'dart:developer';

// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:get_it/get_it.dart';

// Aplication
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/notebook_use_cases.dart';

// Infrastructure
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/notebook_manager_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/notebook_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';

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
  
  getIt.registerLazySingleton<ForPersistingNotebooksPort>(
    () => NotebookDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso agrupados (Application Service)
  getIt.registerLazySingleton<ForManagingNotebooksPort>(
    () => NotebookApplicationServices(getIt<ForPersistingNotebooksPort>())
  );
  
  // Adaptador de gestión de Notebooks UI (Driver Port) 
  getIt.registerLazySingleton<NotebookManagerAdapter>(
    () => NotebookManagerAdapter(getIt<ForManagingNotebooksPort>())
  );
}

Future<void> _setupBlocs() async {
  // Crear la instancia del NotebookBloc
  final notebookBloc = NotebookBloc(getIt<NotebookManagerAdapter>());
  
  // Cargar datos y comenzar observación
  notebookBloc.add(LoadAllNotebooks());
  notebookBloc.add(WatchAllNotebooks());
  
  // Registrar el NotebookBloc como Singleton (nueva instancia cada vez)
  getIt.registerSingleton<NotebookBloc>(notebookBloc);
}
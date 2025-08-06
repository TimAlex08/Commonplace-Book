// Dart Imports
import 'dart:developer';

// External Imports
import 'package:commonplace_book/app/commonplace_book/database/drift/app_database.dart';
import 'package:get_it/get_it.dart';

// ---------- Notebook Dependencies ---------- //
// Application.
import 'package:commonplace_book/src/commonplace_book/notebook/application/notebook/notebook_application_services.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/notebook_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/notebook_manager_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_notebooks_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_notebooks_port.dart';

// Blocs.
import 'commonplace_book/frontend/features/05-notebooks/state/notebook_bloc/notebook_bloc.dart';



// ---------- Structure Dependencies ---------- //
// Application.
import 'package:commonplace_book/src/commonplace_book/notebook/application/structure/structure_application_services.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/structure_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/structure_manager_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_structures_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_structures_port.dart';



// ---------- Folder Dependencies ---------- //
// Application.
import 'package:commonplace_book/src/commonplace_book/notebook/application/folder/folder_application_services.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/folder_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/folder_manager_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_folders_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_folders_port.dart';



// ------------ Page Dependencies ---------- //
// Application.
import 'package:commonplace_book/src/commonplace_book/notebook/application/page/page_application_services.dart';

// Infrastructure.
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivens/page_drift_repository_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/page_manager_adapter.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivens/for_persisting_pages_port.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/ports/drivers/for_managing_pages_port.dart';



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
  
  // ---------- Notebook Dependencies ---------- //
  // Adaptador de persistencia de Notebooks (Driven Port).
  getIt.registerLazySingleton<ForPersistingNotebooksPort>(
    () => NotebookDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso agrupados (Application Service).
  getIt.registerLazySingleton<ForManagingNotebooksPort>(
    () => NotebookApplicationServices(getIt<ForPersistingNotebooksPort>())
  );
  
  // Adaptador de gestión de Notebooks UI (Driver Port).
  getIt.registerLazySingleton<NotebookManagerAdapter>(
    () => NotebookManagerAdapter(getIt<ForManagingNotebooksPort>())
  );



  // ---------- Folder Dependencias ---------- //
  // Adaptador de persistencia de carpetas (Driven Port).
  getIt.registerLazySingleton<ForPersistingFoldersPort>(
    () => FolderDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso agrupados (Application Service).
  getIt.registerLazySingleton<ForManagingFoldersPort>(
    () => FolderApplicationServices(getIt<ForPersistingFoldersPort>())
  );
  
  // Adaptador de gestion de Structures UI (Driver Port).
  getIt.registerLazySingleton<FolderManagerAdapter>(
    () => FolderManagerAdapter(getIt<ForManagingFoldersPort>())
  );
  
  
  
  // ---------- Page Dependencies ---------- //
  // Adaptador de persistencia de páginas (Driven Port).
  getIt.registerLazySingleton<ForPersistingPagesPort>(
    () => PageDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso agrupados (Application Service).
  getIt.registerLazySingleton<ForManagingPagesPort>(
    () => PageApplicationServices(getIt<ForPersistingPagesPort>())
  );
  
  // Adaptador de gestión de Páginas UI (Driver Port).
  getIt.registerLazySingleton<PageManagerAdapter>(
    () => PageManagerAdapter(getIt<ForManagingPagesPort>())
  );
  
  
  
  // ---------- Structure Dependencies ---------- //
  // Adaptador de persistencia de estructuras (Driven Port).
  getIt.registerLazySingleton<ForPersistingStructuresPort>(
    () => StructureDriftRepositoryAdapter(getIt<AppDatabase>())
  );
  
  // Casos de uso agrupados (Application Service).
  getIt.registerLazySingleton<ForManagingStructuresPort>(
    () => StructureApplicationServices(
      notebookRepo: getIt<ForPersistingNotebooksPort>(),
      structureRepo: getIt<ForPersistingStructuresPort>(),
      folderRepo: getIt<ForPersistingFoldersPort>(),
      pageRepo: getIt<ForPersistingPagesPort>(),
    )
  );
  
  // Adaptador de gestion de Structures UI (Driver Port).
  getIt.registerLazySingleton<StructureManagerAdapter>(
    () => StructureManagerAdapter(getIt<ForManagingStructuresPort>())
  );
}

Future<void> _setupBlocs() async {
  // ---------- NotebookBloc ---------- //
  // Crear la instancia del NotebookBloc.
  final notebookBloc = NotebookBloc(getIt<NotebookManagerAdapter>());
  
  // Cargar datos y comenzar observación.
  notebookBloc.add(LoadAllNotebooks());
  notebookBloc.add(WatchAllNotebooks());
  
  // Registrar el NotebookBloc como Singleton (nueva instancia cada vez).
  getIt.registerSingleton<NotebookBloc>(notebookBloc);
}
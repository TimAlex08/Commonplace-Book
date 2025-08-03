// Library
library;

// Flutter Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_view.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/folder_cubit/folder_cubit.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/structure_bloc/structure_bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/routes/app_routes.dart';
import 'package:commonplace_book/src/commonplace_book/notebook/infrastructure/adapters/drivers/structure_manager_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/state/notebook_bloc/notebook_bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:commonplace_book/app/dependency_injection.dart';

part 'widgets/notebook_viewer_drawer.dart';
part 'widgets/notebook_viewer_appbar.dart';




class NotebookViewerPage extends StatelessWidget {
  const NotebookViewerPage({super.key, required this.notebook});
  final NotebookUiModel notebook;

  static Route<void> route({required NotebookUiModel notebook}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<NotebookBloc>()
          ),
          
          BlocProvider(create: (_) {
            return StructureBloc(
              getIt<StructureManagerAdapter>(), 
              notebookId: notebook.id!
              )..add(LoadNotebookStructure(notebook.id!))
               ..add(WatchNotebookStructure(notebook.id!));
          }),
        ],
        child: Builder(
          builder: (context) {
            return BlocProvider(
              create: (_) => FolderCubit(context.read<StructureBloc>()),
              child: NotebookViewerPage(notebook: notebook),
            );
          },
        )
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotebookViewerAppBar(notebookName: notebook.name),
      body: Center(child: Text(notebook.name)),
      drawer: NotebookViewerDrawer(notebook: notebook),
    );
  }
}
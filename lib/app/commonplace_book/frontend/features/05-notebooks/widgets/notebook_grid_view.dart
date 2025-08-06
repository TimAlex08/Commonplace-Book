// Flutter Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/notebook_viewer_page.dart';
import 'package:flutter/material.dart';

// External Imports
import 'package:pie_menu/pie_menu.dart';

// Internal Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/pages/notebook_edit_page.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/widgets/widgets.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';



class NotebookGridView extends StatelessWidget {
  const NotebookGridView({
    super.key, 
    required this.notebooks
  });
  
  final List<NotebookUiModel> notebooks;

  @override
  Widget build(BuildContext context) {
    final screenWidthSize = MediaQuery.of(context).size.width;
    
    return PieCanvas(
      
      theme: PieTheme(
        buttonTheme: PieButtonTheme(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer, 
          iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidthSize > 600
            ? 3
            : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8
        ),
        itemCount: notebooks.length,
        itemBuilder: (context, index) {
          final notebook = notebooks[index];
          
          return PieMenu(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                NotebookViewerPage.route(notebook: notebook),
                (route) => route.isFirst,
              );
            },
            actions: _pieMenuAction(context, notebook),
            child: SizedBox.expand(
              child: SizedBox(child: NotebookCardDesing(notebook: notebook)),
            )
          );
        },
      ),
    );
  }
}



List<PieAction> _pieMenuAction(BuildContext context, NotebookUiModel notebook) {
  return [PieAction(
      tooltip: const Text('Editar'), 
      onSelect: () => {
        Navigator.of(context).push(
          NotebookEditPage.route(initialNotebook: notebook)
        )
      }, 
      child: const Icon(Icons.edit)
    ),
    PieAction(
      tooltip: const Text('Archivar'), 
      onSelect: () => {}, 
      child: const Icon(Icons.archive_rounded)
    )
  ];
}
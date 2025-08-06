// Flutter Imports.
import 'package:flutter/material.dart';

// Components.
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/structure_form_dialog.dart';

// Models.
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_form_model.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_ui_model.dart';



// ---------- Add Content Button ---------- //
class AddContentButton extends StatelessWidget {
  const AddContentButton({
    super.key, 
    required this.notebookId,
    required this.iconColor,
    required this.baseStructure,
  });

  final String notebookId;
  final Color iconColor;
  final StructureUiModel baseStructure;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.add,
        color: iconColor, // El color del ícono se inyecta
        size: 18,
      ),
      tooltip: 'Agregar contenido',
      onSelected: (value) {
        final type = value == 'page'
            ? StructureItemType.page
            : StructureItemType.folder;
            
        final newStructure = StructureUiModel(
          structureId: baseStructure.structureId,
          notebookId: baseStructure.notebookId,
          parentId: baseStructure.parentId,
          type: type.name, // Solo esto cambia según la selección
          folderId: baseStructure.folderId,
          pageId: baseStructure.pageId,
          position: baseStructure.position,
          depth: baseStructure.depth,
        );

        openStructureFormDialog(
          context: context,
          structureModel: newStructure,
          type: type,
        );
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'page',
          child: ListTile(
            leading: Icon(Icons.note_add_outlined),
            title: Text('Agregar página'),
          ),
        ),
        const PopupMenuItem(
          value: 'folder',
          child: ListTile(
            leading: Icon(Icons.create_new_folder_outlined),
            title: Text('Agregar carpeta'),
          ),
        ),
      ],
    );
  }
}
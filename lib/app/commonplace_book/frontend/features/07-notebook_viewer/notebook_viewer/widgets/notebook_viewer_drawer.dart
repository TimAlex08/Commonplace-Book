part of '../notebook_viewer_page.dart';



// ---------- NotebookViewerDrawer ---------- //
class NotebookViewerDrawer extends StatelessWidget {
  const NotebookViewerDrawer({super.key, required this.notebook});
  final NotebookUiModel notebook;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: SafeArea(
        child: Column(
          children: [
            _drawerHeader(context, notebook),
            _contentHeaderListTile(context, notebook),
            _contentListTile(context),
          ],
        )
      ),
    );
  }
}

Widget _drawerHeader(BuildContext context, NotebookUiModel notebook) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
      color: notebook.color.toColor(),
      borderRadius: BorderRadius.circular(8)
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            notebook.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: notebook.color.toColor().computeLuminance() > 0.5 ? Colors.black54 : Colors.white70
            ),
            
          )
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
          color: notebook.color.toColor().computeLuminance() > 0.5 ? Colors.black54 : Colors.white70,
        )
      ]
    )
  );
}

Widget _contentHeaderListTile(BuildContext context, NotebookUiModel notebook) {
  return ListTile(
    tileColor: Colors.grey[300],
    title: Text('Contenido'),
    contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.note_add),
          tooltip: 'Agregar página',
          padding: EdgeInsets.zero,
          onPressed: () {
            final rootPageStructure = StructureUiModel(
              structureId: null,
              notebookId: notebook.id!,
              parentId: null,
              type: StructureItemType.page.name,
              folderId: null,
              pageId: null,
              position: null,
              depth: 0,
            );

            openStructureFormDialog(
              context: context,
              structureModel: rootPageStructure,
              type: StructureItemType.page,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.create_new_folder),
          tooltip: 'Agregar carpeta',
          padding: EdgeInsets.zero,
          onPressed: () {
            final rootFolderStructure = StructureUiModel(
              structureId: null,
              notebookId: notebook.id!,
              parentId: null,
              type: StructureItemType.folder.name,
              folderId: null,
              pageId: null,
              position: null,
              depth: 0,
            );

            openStructureFormDialog(
              context: context,
              structureModel: rootFolderStructure,
              type: StructureItemType.folder,
            );
          },
        )
      ],
    ),
  );
}

Widget _contentListTile(BuildContext context) {
  return Expanded(
    child: BlocBuilder<FolderCubit, FolderState>(
      builder: (context, state) {
        final visibleStructures = state.visibleStructures;

        if (visibleStructures.isEmpty) {
          return const Center(child: Text('No hay elementos visibles'));
        }

        return CollapsableStructureList(structures: visibleStructures);
      },
    ),
  );
}




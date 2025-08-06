part of 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_view.dart';



// ---------- TreeView Header ---------- //
class _TreeViewHeader extends StatelessWidget {
  const _TreeViewHeader({
    required this.notebook,
    required this.state
  });

  final NotebookUiModel notebook;
  final StructureState state;
  

  @override
  Widget build(BuildContext context) {
    final bool isReorderMode = state.isReorderMode;
    final Color backgroundColor = notebook.color.toColor();
    final Color contrastingColor = getContrastingTextColor(backgroundColor);
    
    final newStructure = StructureUiModel(
      structureId: null,
      notebookId: notebook.id!, // El notebookId se inyecta
      parentId: null,
      type: '',
      folderId: null,
      pageId: null,
      position: null,
      depth: 0,
    );
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          Text(
            notebook.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: contrastingColor,
            ),
          ),
          const Spacer(),
          
          AddContentButton(
            notebookId: notebook.id!,
            iconColor: contrastingColor,
            baseStructure: newStructure,
            
          ),
          
          IconButton(
            icon: Icon(
              isReorderMode ? Icons.check : Icons.reorder,
              color: contrastingColor,
              size: 16,
            ),
            onPressed: () {
              context.read<StructureBloc>().add(ToggleReorderMode());
            },
            tooltip: isReorderMode ? 'Finalizar reordenamiento' : 'Reordenar elementos',
          ),
        ],
      ),
    );
  }
}
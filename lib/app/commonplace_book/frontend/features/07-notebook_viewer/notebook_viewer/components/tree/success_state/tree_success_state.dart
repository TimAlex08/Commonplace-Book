part of 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_view.dart';



class _TreeSuccessState extends StatelessWidget {
  const _TreeSuccessState({
    required this.notebook,
    required this.state
  });

  final NotebookUiModel notebook;
  final StructureState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TreeViewHeader(notebook: notebook, state: state),

        if(state.treeNodes.isEmpty)
          const Expanded(child: _EmptyContentState())
        else
          Expanded(child: _TreeViewContent(notebook: notebook, state: state)),
      ],
    );
  }
}
part of 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_view.dart';



// ---------- Tree View Content ---------- //
class _TreeViewContent extends StatelessWidget {
  const _TreeViewContent({
    required this.notebook,
    required this.state,
  });
  
  final NotebookUiModel notebook;
  final StructureState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: !state.isReorderMode
        ? _BuildNormalTree(state: state)
        : _BuilReordenableTree(state: state)
    );
  }
}



// ---------- BuildNormalTree ---------- //
class _BuildNormalTree extends StatelessWidget {
  const _BuildNormalTree({
    required this.state
  });

  final StructureState state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) { 
              return _TreeNodeWidget(
                node: state.treeNodes[index],
                depth: 0,
                state: state,
              );
            },
            childCount: state.treeNodes.length,
          )
        )
      ],
    );
  }
}



class _TreeNodeWidget extends StatelessWidget {
  const _TreeNodeWidget({
    required this.node,
    required this.depth,
    required this.state,
  });

  final TreeNode node;
  final int depth;
  final StructureState state;

  @override
  Widget build(BuildContext context) {
    final isExpanded = state.expandedNodes[node.content.structureId] ?? false;
    final hasChildren = node.children.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TreeItemWidget(
          node: node,
          depth: depth,
          isExpanded: isExpanded,
        ),

        // Renderizar hijos si está expandido.
        if (hasChildren && isExpanded)
          ...node.children.map((child) { 
            return _TreeNodeWidget(
              node: child,
              depth: depth + 1,
              state: state,
            );
          }
        ),
      ],
    );
  }
}



class _TreeItemWidget extends StatelessWidget {
  const _TreeItemWidget({
    required this.node,
    required this.depth,
    required this.isExpanded,
  });

  final TreeNode node;
  final int depth;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final isFolder = node.content.type == 'folder';
    final String structureId = node.content.structureId!;

    final newStructure = StructureUiModel(
      notebookId: node.content.notebookId,
      parentId: node.content.structureId,
      type: '',
      depth: depth + 1,
    );

return Container(
      margin: EdgeInsets.only(left: depth * 16.0, top: 2, bottom: 2),
      height: 45,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap:  () {
            if (isFolder) {
              context.read<StructureBloc>().add(ToggleExpansion(structureId));
            } else {}
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                if (isFolder)
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 20,
                    color: Colors.grey[600],
                  )
                else
                  const SizedBox(width: 20),
                const SizedBox(width: 8),
                
                Icon(
                  isFolder ? (isExpanded ? Icons.folder_open : Icons.folder) : Icons.description,
                  color: isFolder ? Colors.amber[700] : Colors.blue[600],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    node.content.displayName ?? 'Sin título',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isFolder)
                  AddContentButton(
                    notebookId: node.content.notebookId,
                    iconColor: Colors.black,
                    baseStructure: newStructure,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class _BuilReordenableTree extends StatelessWidget {
  const _BuilReordenableTree({required this.state});
  
  final StructureState state;

  // FUNCIÓN AUXILIAR 1
  String? _findParentIdForNodeAt(int index, List<FlattenedNode> nodes) {
    if (index < 0 || index >= nodes.length) return null;
    final targetDepth = nodes[index].depth;
    if (targetDepth == 0) return null;

    for (int i = index - 1; i >= 0; i--) {
      if (nodes[i].depth < targetDepth) {
        return nodes[i].node.content.structureId;
      }
    }
    return null;
  }

  // FUNCIÓN AUXILIAR 2
  int _calculatePositionAmongSiblings(int targetIndex, String? parentId, List<FlattenedNode> nodes) {
    int position = 0;
    for (int i = 0; i < targetIndex; i++) {
      final nodeParentId = _findParentIdForNodeAt(i, nodes);
      if (nodeParentId == parentId) {
        position++;
      }
    }
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final flattenedNodes = TreeNodeBuilder.flattenTreeForReordering(state.treeNodes, state.expandedNodes);
    
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) newIndex -= 1;

        final draggedFlatNode = flattenedNodes[oldIndex];
        final targetFlatNode = flattenedNodes[newIndex];

        if (draggedFlatNode.node.content.structureId == targetFlatNode.node.content.structureId) return;

        String? newParentId;
        int newPosition;

        final isTargetFolder = targetFlatNode.node.content.type == 'folder';
        final isTargetExpanded = state.expandedNodes[targetFlatNode.node.content.structureId] ?? false;

        if (isTargetFolder && isTargetExpanded) {
          newParentId = targetFlatNode.node.content.structureId;
          newPosition = 0; 
        } else {
          newParentId = _findParentIdForNodeAt(newIndex, flattenedNodes);
          newPosition = _calculatePositionAmongSiblings(newIndex, newParentId, flattenedNodes);
        }

        if (draggedFlatNode.node.content.structureId == newParentId) return;

        context.read<StructureBloc>().add(
          ReorderItem(
            draggedItemId: draggedFlatNode.node.content.structureId!,
            newParentId: newParentId,
            newPosition: newPosition,
          ),
        );
      },
      itemCount: flattenedNodes.length,
      itemBuilder: (context, index) {
        final flatNode = flattenedNodes[index];
        return _ReorderableTreeItem(
          key: ValueKey(flatNode.node.content.structureId!), 
          node: flatNode.node,
          depth: flatNode.depth,
          index: index,
          isExpanded: flatNode.node.isExpanded,
        );
      },
    );
  }
}


class _ReorderableTreeItem extends StatelessWidget {
  const _ReorderableTreeItem({
    required Key key, 
    required this.node,
    required this.depth,
    required this.index,
    required this.isExpanded
  }) : super(key: key);

  final TreeNode node;
  final int depth;
  final int index;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final isFolder = node.content.type == 'folder';

    return Container(
      margin: EdgeInsets.only(left: depth * 16.0, top: 2, bottom: 2),
      height: 45,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[50],
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            if (isFolder) {
              context.read<StructureBloc>().add(ToggleExpansion(node.content.structureId!));
            } else {}
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                if (isFolder)
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 20,
                    color: Colors.grey[600],
                  )
                else
                  const SizedBox(width: 20),

                const SizedBox(width: 8),
                Icon(
                  isFolder ? (isExpanded ? Icons.folder_open : Icons.folder) : Icons.description,
                  color: isFolder ? Colors.amber[700] : Colors.blue[600],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    node.content.displayName ?? 'Sin título',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ReorderableDragStartListener(
                  index: index,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.drag_handle, color: Colors.grey, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Flutter Imports.
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_node_builder.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/structure_bloc/structure_bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/utils/color_utils.dart';
import 'package:flutter/material.dart';

// Models.
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Components.
import 'components/add_content_button.dart';


part 'success_state/tree_success_state.dart';
part 'success_state/tree_view_header.dart';
part 'success_state/tree_view_content.dart';
part 'success_state/empty_content_state.dart';
part 'failure_state/tree_failure_state.dart';



class TreeView extends StatelessWidget {
  const TreeView({
    super.key,
    required this.notebook,
    this.padding,
    this.onItemTap,
  });

  final NotebookUiModel notebook;
  final EdgeInsetsGeometry? padding;
  final Function(String structureId)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StructureBloc, StructureState>(
      builder: (context, state) {
        switch (state.status) {
          // Estado de inicio y carga.
          case StructureStatus.initial:
          case StructureStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          
          // Estado de éxito.
          case StructureStatus.success:
            return _TreeSuccessState(notebook: notebook, state: state);
            
          // Estado de falla.
          case StructureStatus.failure:
            return _TreeFailureState(state: state, notebookId: notebook.id!);
        }
      },
    );
  }
}



// Widget _buildTreeView(BuildContext context, StructureState state, NotebookUiModel notebook) {
//   return Container(
//     padding: const EdgeInsets.all(8),
//     child: Column(
//       children: [
//         // Header con controles
//         _buildTreeHeader(context, state, notebook),
//         //Text('Se esta creando builTreeView'),
//         Expanded(
//           child: _buildNormalTree(context, state)
//         )
//       ],
//     ),
//   );
// }
// 
// Widget _buildTreeHeader(BuildContext context, StructureState state, NotebookUiModel notebook) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     decoration: BoxDecoration(
//       color: Colors.grey[50],
//       border: Border(
//         bottom: BorderSide(color: Colors.grey[200]!),
//       )
//     ),
//     child: Row(
//       children: [
//         Icon(Icons.folder_outlined, color: Colors.grey[600], size: 20),
//         const SizedBox(width: 8),
//         Text(
//          notebook.name,
//          style: Theme.of(context).textTheme.titleSmall?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[800],
//          ),
//         ),
//         
//         const Spacer(),
//         
//         PopupMenuButton<String>(
//           icon: const Icon(Icons.add, size: 18),
//           tooltip: 'Agregar contenido',
//           onSelected: (value) {
//             final type = value == 'page'
//                 ? StructureItemType.page
//                 : StructureItemType.folder;
//     
//             final newStructure = StructureUiModel(
//               structureId: null,
//               notebookId: notebook.id!,
//               parentId: null,
//               type: type.name,
//               folderId: null,
//               pageId: null,
//               position: null,
//               depth: 0
//             );
//     
//             openStructureFormDialog(
//               context: context,
//               structureModel: newStructure,
//               type: type,
//             );
//           },
//           itemBuilder: (context) => [
//             const PopupMenuItem(
//               value: 'page',
//               child: ListTile(
//                 leading: Icon(Icons.note_add_outlined),
//                 title: Text('Agregar página'),
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'folder',
//               child: ListTile(
//                 leading: Icon(Icons.create_new_folder_outlined),
//                 title: Text('Agregar carpeta'),
//               ),
//             ),
//           ],
//         ),
//         
//         // Botón de modo reordenamiento
//         IconButton(
//           icon: Icon(
//             state.isReorderMode ? Icons.check : Icons.reorder,
//             color: state.isReorderMode ? Colors.green : Colors.grey[600],
//             size: 16,
//           ),
//           onPressed: () {
//             context.read<StructureBloc>().add(ToggleReorderMode());
//           },
//           tooltip: state.isReorderMode ? 'Finalizar reordenamiento' : 'Reordenar elementos',
//         ),
//       ],
//     ),
//   );
// }
// 
// 
// 
// // ---------- Construcción del árbol ---------- //
// Widget _buildNormalTree(BuildContext context, StructureState state) {
//   return CustomScrollView(
//     slivers: [
//       SliverList(
//         delegate: SliverChildBuilderDelegate(
//           (context, index) => _buildTreeNode(
//             context,
//             state.treeNodes[index],
//             0,
//             state,
//           ),
//           childCount: state.treeNodes.length,
//         )
//       )
//     ],
//   );
// }
// 
// Widget _buildTreeNode(BuildContext context, TreeNode node, int depth, StructureState state) {
//   final isExpanded = state.expandedNodes[node.content.structureId] ?? false;
//   final hasChildren = node.children.isNotEmpty;
//   
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _buildTreeItem(context, node, depth, state, isExpanded),
//       
//       // Renderizar hijos si está expandido
//       if (hasChildren && isExpanded)
//         ...node.children.map((child) => _buildTreeNode(
//           context,
//           child,
//           depth + 1,
//           state,
//         )),
//     ],
//   );
// }
// 
// Widget _buildTreeItem(
//   BuildContext context,
//   TreeNode node,
//   int depth,
//   StructureState state,
//   bool isExpanded,
// ) {
//   final isFolder = node.content.type == 'folder';
// 
//   return Container(
//     margin: EdgeInsets.only(
//       left: depth * 16.0,
//       top: 2,
//       bottom: 2,
//     ),
//     height: 45,
//     child: Material(
//       color: Colors.white,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: () {
//           if (isFolder) {
//             context.read<StructureBloc>().add(
//               ToggleExpansion(node.content.structureId!),
//             );
//           } else {}
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey[200]!),
//           ),
//           child: Row(
//             children: [
//               // Icono de expansión para carpetas
//               if (isFolder)
//                 Icon(
//                   isExpanded ? Icons.expand_more : Icons.chevron_right,
//                   size: 20,
//                   color: Colors.grey[600],
//                 )
//               else
//                 // Este SizedBox alinea las páginas con el contenido de las carpetas
//               const SizedBox(width: 20), // Ajustado a 20 para alinear con el espacio del icono de expansión
// 
//               const SizedBox(width: 8),
// 
//               // Icono del tipo
//               Icon(
//                 node.content.type == 'folder'
//                     ? Icons.folder
//                     : Icons.description,
//                 size: 20,
//                 color: Colors.amber,
//               ),
// 
//               const SizedBox(width: 12),
// 
//               // Título
//               Expanded(
//                 child: Text(
//                   node.content.displayName ?? 'Sin título',
//                   style: TextStyle(
//                     fontWeight: isFolder ? FontWeight.w600 : FontWeight.normal,
//                     color: Colors.grey[800],
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
// 
//               if (isFolder) // Solo para carpetas si está permitido
//                 PopupMenuButton<String>(
//                   icon: const Icon(Icons.add, size: 18, color: Colors.grey), // Un color más discreto
//                   tooltip: 'Agregar contenido a esta carpeta',
//                   onSelected: (value) {
//                     final type = value == 'page'
//                         ? StructureItemType.page
//                         : StructureItemType.folder;
// 
//                     // El padre del nuevo elemento será el ID de la carpeta actual (node.content.structureId!)
//                     final newStructure = StructureUiModel(
//                       structureId: null,
//                       notebookId: node.content.notebookId, // Usa el notebookId de la carpeta
//                       parentId: node.content.structureId, // ¡El ID de esta carpeta es el padre!
//                       type: type.name,
//                       folderId: null,
//                       pageId: null,
//                       position: null, // Deja que el backend maneje la posición inicial
//                       depth: depth + 1, // La profundidad será +1 respecto a la carpeta padre
//                     );
// 
//                     openStructureFormDialog(
//                       context: context,
//                       structureModel: newStructure,
//                       type: type,
//                     );
//                   },
//                   itemBuilder: (context) => [
//                     const PopupMenuItem(
//                       value: 'page',
//                       child: ListTile(
//                         leading: Icon(Icons.note_add_outlined),
//                         title: Text('Agregar página'),
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: 'folder',
//                       child: ListTile(
//                         leading: Icon(Icons.create_new_folder_outlined),
//                         title: Text('Agregar carpeta'),
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
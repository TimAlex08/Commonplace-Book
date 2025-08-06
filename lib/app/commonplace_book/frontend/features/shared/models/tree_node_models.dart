// Models
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';



/// Clase para representar un nodo en el árbol jerárquico.
class TreeNode<T extends StructureUiModel> {
  const TreeNode({
    required this.content,
    this.children = const [],
    this.isExpanded = false,
  });
  
  final T content;
  final List<TreeNode<T>> children;
  final bool isExpanded;  
  
  // HasChildren: Getter para verificar si el nodo tiene hijos.
  bool get hasChildren => children.isNotEmpty;
  
  // CopyWith: Método para crear una copia del nodo con modificaciones.
  TreeNode<T> copyWith({
    T? content,
    List<TreeNode<T>>? children,
    bool? isExpanded,
  }) {
    return TreeNode<T>(
      content: content ?? this.content,
      children: children ?? this.children,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}



class FlattenedNode<T extends StructureUiModel> {
  const FlattenedNode({
    required this.node,
    required this.depth,
  });
  
  final TreeNode<T> node;
  final int depth;
}
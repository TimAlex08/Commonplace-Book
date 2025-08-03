// Models
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';



/// Clase que contiene la lógica para construir y manipular árboles de nodos.
class TreeNodeBuilder {
  // ---------- Método para construir nodos de árbol ---------- //
  // Convierte la lista plana de StructureUiModel en una estructura de árbol de TreeSliverNode.
  static List<TreeNode<StructureUiModel>> buildTreeNodes(List<StructureUiModel> data, Map<String, bool> expandedNodes) {
    // 1.- Agrupación por parentId.
    // • Crea un mapa donde la clave es el `parentId` y el valor es una lista de elementos hijos.
    // • ??= Significa: "Si la clave no existe".
    // Ejemplo:
    // {
    //   null: [Item A],
    //   "A": [Item B, Item C],
    //   "B": [Item D]
    // }
    final Map<String?, List<StructureUiModel>> childrenMap = {};
    for(final item in data) {
      (childrenMap[item.parentId] ??= []).add(item);
    }
    
    // 2.- Construcción recursiva del árbol.
    List<TreeNode<StructureUiModel>> buildNodesRecursive(String? parentId) {
      final List<StructureUiModel> items = childrenMap[parentId] ?? [];
      
      // Ordena los elementos por su propiedad `position`.
      // • Si position es null, usa 0 como valor por defecto.
      // • compareTo devuelve: negativo (a < b), 0 (a = b), positivo (a > b).
      items.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));
      
      return items.map((item) {
        // Determina si el nodo debe estar expandido basándose en el mapa provisto.
        final bool isNodeExpanded = expandedNodes[item.structureId] ?? false;
        
        if(item.type == 'folder') {
          return TreeNode<StructureUiModel>(
            content: item,
            children: buildNodesRecursive(item.structureId),
            isExpanded: isNodeExpanded
          );
        } else {
          return TreeNode<StructureUiModel>(content: item);
        }
      }).toList();
    }
    
    // Construye el árbol empezando por los nodos raiz (parentId es null).
    return buildNodesRecursive(null);
  }
  
  
  // ---------- Método para aplanar el árbol ---------- //
  /// Retorna una lista aplanada de nodos con sus metadatos, incluyendo la ruta para encontrarlos.
  static List<FlattenedNode<StructureUiModel>> flattenTree(
    List<TreeNode<StructureUiModel>> nodes,
    int depth,
  ) {
    final List<FlattenedNode<StructureUiModel>> flattened = [];
    
    for(int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
   
      flattened.add(FlattenedNode(
        node: node,
        depth: depth,
      ));
      
      if(node.isExpanded && node.hasChildren) {
        flattened.addAll(flattenTree(node.children, depth + 1));
      }
    }
    return flattened;
  }
  
  /// Retorna una lista aplanada para el modo de reordenamiento.
  static List<FlattenedNode<StructureUiModel>> flattenTreeForReordering(
    List<TreeNode> nodes,
    Map<String, bool> expandedNodes,
  ) {
    final List<FlattenedNode> flattened = [];
    
    void flattenRecursive(List<TreeNode> nodeList, int depth) {
      for(final node in nodeList) {
        flattened.add(FlattenedNode(node: node, depth: depth));
        
        if(node.content.type == 'folder' && (expandedNodes[node.content.structureId] ?? false)) {
          flattenRecursive(node.children, depth + 1);
        }
      }
    }
    
    flattenRecursive(nodes, 0);
    return flattened;
  }
  
  
  /// Cuenta el número total de nodos aplanados en el árbol.
  static int countFlattenedNodes(List<TreeNode<StructureUiModel>> tree) {
    return flattenTree(tree, 0).length;
  }
  
  
  /// Obtiene un nodo aplanado por su indice en la lista aplanada.
  static FlattenedNode<StructureUiModel>? getFlattenedNode(
    List<TreeNode<StructureUiModel>> tree,
    int index,
  ) {
    final flattenedNodes = flattenTree(tree, 0);
    return index >= 0 && index < flattenedNodes.length
      ? flattenedNodes[index]
      : null;
  }
}
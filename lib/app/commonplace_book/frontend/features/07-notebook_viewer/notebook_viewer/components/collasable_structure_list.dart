import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/components.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/folder_cubit/folder_cubit.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ---------- Collapsable Structure Builder ---------- //
class CollapsableStructureList extends StatelessWidget {
  const CollapsableStructureList({
    super.key,
    required this.structures,
    this.onPageTap,
    this.onFolderTap,
    this.onAddToFolder
  });
  
  final List<StructureUiModel> structures;
  final Function(StructureUiModel)? onPageTap;
  final Function(StructureUiModel)? onFolderTap;
  final Function(StructureUiModel)? onAddToFolder;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FolderCubit>().setAllStructures(structures);
    });
    
    if(structures.isEmpty) {
      return Center(child: Text('No hay contenido'));
    }
    
    return BlocBuilder<FolderCubit, FolderState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: ListView.builder(
            itemCount: state.visibleStructures.length,
            itemBuilder: (context, index) {
              final item = state.visibleStructures[index];
              final isFolder = item.type == 'folder';
              
              return CollapsibleListTile(
                structure: item,
                isFolder: isFolder,
                onTrailingTap: () {},
              );
            },
          ),
        );
      },
    );
  }
}

class CollapsibleListTile extends StatelessWidget {
  const CollapsibleListTile({
    super.key,
    required this.structure,
    required this.isFolder,
    this.onTap,
    this.onTrailingTap
  });

  final StructureUiModel structure;
  final bool isFolder;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderCubit, FolderState>(
      // Solo reconstruir si el estado de expansison de esta carpeta cambió.
      buildWhen: (previous, current) {
        if(isFolder && structure.folderId != null) {
          return previous.expandedFolders[structure.folderId] != 
                 current.expandedFolders[structure.folderId];
        }
        return false;
      },
      
      builder: (context, state) {
        final isExpanded = isFolder && structure.folderId != null
          ? (state.expandedFolders[structure.folderId] ?? false)
          : false;
          
        final hasChildren = isFolder && structure.folderId != null
          ? context.read<FolderCubit>().hasChildren(structure.folderId!)
          : false;
        
        return CustomListTile(
          title: structure.displayName ?? 'Sin título',
          isFolder: isFolder,
          isExpanded: isExpanded,
          hasChildren: hasChildren,
          indentLevel: (structure.depth ?? 0).toDouble(),
          onTap: isFolder && structure.folderId != null
            ? () {
              print('Toggling folder: ${structure.folderId}');
              context.read<FolderCubit>().toggleFolder(structure.folderId!);
            } 
            : null,
          onTrailingTap: onTrailingTap,
          trailing: isFolder
            ? _FolderContextMenu(structure: structure)
            : null
        );
      },
    );
  }
}



class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.indentLevel = 0,
    this.onTap,
    this.onTrailingTap,
    required this.isFolder,
    this.isExpanded = false,
    this.hasChildren = false,
    this.trailing
  });

  final String title;
  final double height;
  final double borderRadius;
  final double indentLevel;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;
  final bool isFolder;
  final bool isExpanded;
  final bool hasChildren;
  final Widget? trailing;
  
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = theme.cardColor;
    final defaultTextColor = theme.textTheme.bodyLarge?.color;
    final iconBackgroundColor = Colors.grey[300];
    
    // final IconData leadingIcon = isFolder ? Icons.chevron_right : Icons.circle;

    return Container(
      height: height,
      margin: EdgeInsets.only(
        left: 0,
        bottom: 1.0,
        right: 0,
        top: 1.0
      ),
      child: Material(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(
              left: indentLevel * 8.0 + 8.0,
              right: 8.0,
            ),
            child: Row(
              children: [
                _buildLeadingIcon(
                  iconBackgroundColor,
                  isFolder,
                  hasChildren,
                  isExpanded
                ),
                
                SizedBox(width: 8.0),
                
                // Title.
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: isFolder ? FontWeight.w400 : FontWeight.w400,
                      color: defaultTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                
                // Trailing.
                if (trailing != null) ...[
                  const SizedBox(width: 8.0),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}



Widget _buildLeadingIcon(Color? color, bool isFolder, bool hasChildren, bool isExpanded) {
  if (isFolder) {
    // Solo mostrar icono de flecha si la carpeta tiene hijos
    if (hasChildren) {
      return AnimatedRotation(
        turns: isExpanded ? 0.25 : 0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(
            Icons.chevron_right,
            size: 16.0,
            color: color,
          ),
        ),
      );
    } else {
      // Carpeta vacía - mostrar icono de carpeta sin flecha
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Icon(
          Icons.folder_outlined,
          size: 16.0,
          color: color,
        ),
      );
    }
  } else {
    // Icono para páginas
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(
        Icons.description_outlined,
        size: 16.0,
        color: color,
      ),
    );
  }
}



class _FolderContextMenu extends StatelessWidget {
  const _FolderContextMenu({required this.structure});

  final StructureUiModel structure;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.add, size: 18),
      tooltip: 'Agregar contenido',
      onSelected: (value) {
        final type = value == 'page'
            ? StructureItemType.page
            : StructureItemType.folder;

        final newStructure = StructureUiModel(
          structureId: null,
          notebookId: structure.notebookId,
          parentId: structure.structureId,
          type: type.name,
          folderId: null,
          pageId: null,
          position: null,
          depth: (structure.depth ?? 0) + 1,
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
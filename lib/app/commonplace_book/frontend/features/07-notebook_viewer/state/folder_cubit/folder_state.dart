part of 'folder_cubit.dart';

class FolderState extends Equatable {
  const FolderState({
    this.expandedFolders = const {},
    this.visibleStructures = const []
  });

  final Map<String, bool> expandedFolders;
  final List<StructureUiModel> visibleStructures;

  FolderState copyWith({
    Map<String, bool>? expandedFolders,
    List<StructureUiModel>? visibleStructures,
  }) {
    return FolderState(
      expandedFolders: expandedFolders ?? this.expandedFolders,
      visibleStructures: visibleStructures ?? this.visibleStructures
    );
  }

  @override
  List<Object> get props => [expandedFolders, visibleStructures];
}
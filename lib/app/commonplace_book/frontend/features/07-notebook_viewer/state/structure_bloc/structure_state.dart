part of 'structure_bloc.dart';

enum StructureStatus { initial, loading, success, failure }

final class StructureState extends Equatable {
  const StructureState({
    required this.notebookId,
    this.status = StructureStatus.initial,
    this.rawStructures = const <StructureUiModel>[],
    this.treeNodes = const <TreeNode<StructureUiModel>>[],
    this.isReorderMode = false,
    this.expandedNodes = const {},
    this.userMessage
  });
  
  final String notebookId;
  final StructureStatus status;
  final List<StructureUiModel> rawStructures;
  final List<TreeNode<StructureUiModel>> treeNodes;
  final bool isReorderMode;
  final Map<String, bool> expandedNodes;
  final UserMessage? userMessage;
  
  StructureState copyWith({
    String? notebookId,
    StructureStatus? status,
    List<StructureUiModel>? rawStructures,
    List<TreeNode<StructureUiModel>>? treeNodes,
    bool? isReorderMode,
    Map<String, bool>? expandedNodes,
    UserMessage? userMessage,
  }) {
    return StructureState(
      notebookId: notebookId ?? this.notebookId,
      status: status ?? this.status,
      rawStructures: rawStructures ?? this.rawStructures,
      treeNodes: treeNodes ?? this.treeNodes,
      isReorderMode: isReorderMode ?? this.isReorderMode,
      expandedNodes: expandedNodes ?? this.expandedNodes,
      userMessage: userMessage ?? this.userMessage
    );
  }
  
  @override
  List<Object?> get props => [
    notebookId,
    status,
    rawStructures,
    treeNodes,
    isReorderMode,
    expandedNodes, 
    userMessage
  ];
}

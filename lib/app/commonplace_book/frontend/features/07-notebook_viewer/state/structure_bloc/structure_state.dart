part of 'structure_bloc.dart';

enum StructureStatus { initial, loading, success, failure }

final class StructureState extends Equatable {
  const StructureState({
    required this.notebookId,
    this.status = StructureStatus.initial,
    this.structures = const <StructureUiModel>[],
    this.userMessage
  });
  
  final String notebookId;
  final StructureStatus status;
  final List<StructureUiModel> structures;
  final UserMessage? userMessage;
  
  StructureState copyWith({
    String? notebookId,
    StructureStatus? status,
    List<StructureUiModel>? structures,
    UserMessage? userMessage,
  }) {
    return StructureState(
      notebookId: notebookId ?? this.notebookId,
      status: status ?? this.status,
      structures: structures ?? this.structures,
      userMessage: userMessage ?? this.userMessage
    );
  }
  
  @override
  List<Object?> get props => [notebookId, status, structures, userMessage];
}

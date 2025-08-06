part of 'structure_form_cubit.dart';

enum StructureFormStatus { initial, loading, failure, success }

extension StructureFormStatusX on StructureFormStatus {
    bool get isLoadingOrSuccess => [
    StructureFormStatus.loading,
    StructureFormStatus.success
  ].contains(this);
}

final class StructureFormState extends Equatable {
  const StructureFormState({
    required this.formModel,
    this.initialFormModel,
    this.status = StructureFormStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });
  
  final StructureFormModel formModel;
  final StructureFormModel? initialFormModel;
  final StructureFormStatus status;
  final bool isValid;
  final Map<String, List<String>>? errorMessage;

  bool get isNewStructure => initialFormModel == null;

  StructureFormState copyWith({
    StructureFormModel? formModel,
    StructureFormModel? initialFormModel,
    StructureFormStatus? status,
    bool? isValid,
    Map<String, List<String>>? errorMessages,
  }) {
    return StructureFormState(
      formModel: formModel ?? this.formModel,
      initialFormModel: initialFormModel ?? this.initialFormModel,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessages,
    );
  }

  /// StructureFormState.create: Constructor para creación.
  factory StructureFormState.create({
    required StructureUiModel structureModel,
    required StructureItemType type,
  }) {
    return StructureFormState(
      formModel: StructureFormModel.fromStructure(
        structureModel: structureModel, 
        type: type
      ),
      initialFormModel: null,
      isValid: false,
    );
  }
  
  /// StructureFormState.edit: Constructor inicial para edición.
  factory StructureFormState.edit(StructureFormModel initialFormModel) {
    return StructureFormState(
      formModel: initialFormModel,
      initialFormModel: initialFormModel,
      isValid: initialFormModel.title.trim().isNotEmpty,
    );
  }
  
  @override
  List<Object?> get props => [formModel, initialFormModel, status, isValid, errorMessage];
}
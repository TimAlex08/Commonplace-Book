import 'package:bloc/bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_form_model.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'structure_form_state.dart';

class StructureFormCubit extends Cubit<StructureFormState> {
  /// StructureFormCubit.create: Constructor para creación.
  StructureFormCubit.create({
    required StructureUiModel structureModel,
    required StructureItemType type,
  }) : super(
    StructureFormState.create(
      structureModel: structureModel,
      type: type
    )
  );
  
  /// Constructor para edición
  StructureFormCubit.edit({
    required StructureFormModel initialModel,
  }) : super(
    StructureFormState(
      formModel: initialModel,
      initialFormModel: initialModel,
      isValid: initialModel.title.trim().isNotEmpty,
    ),
  );
  
  
  /// TitleChanged EventHandler: Cambiar el título.
  void titleChanged(String newTitle) {
    final updated = state.formModel.copyWith(title: newTitle);
    final errors = _validateTitle(newTitle);
    
    emit(state.copyWith(
      formModel: updated,
      isValid: newTitle.trim().isNotEmpty,
      errorMessages: _buildErrorMap(errors),
    ));
  }
  
  static List<String> _validateTitle(String title) {
    final errors = <String>[];
    if(title.trim().isEmpty) {
      errors.add('Titulo requerido');
    }
    
    if(title.length > 100) {
      errors.add('El titulo no debe superar 100 caracteres');
    }
    
    return errors;
  }
  
  static Map<String, List<String>>? _buildErrorMap(List<String> errors) {
    if (errors.isEmpty) return null;
    return {'title': errors};
  }
}

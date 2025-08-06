import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/structure_bloc/structure_bloc.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/state/structure_form_cubit/structure_form_cubit.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_form_model.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/structure_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// ---------- FormDialog ---------- //
void openStructureFormDialog({
  required BuildContext context,
  required StructureUiModel structureModel,
  required StructureItemType type,
}) {
  
  final structureBloc = context.read<StructureBloc>();
  
  showDialog(
    context: context,
    builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: structureBloc),
          BlocProvider(
            create: (_) => StructureFormCubit.create(
              structureModel: structureModel,
              type: type,
            ),
          ),
        ],
        child: const StructureFormDialog(),
      );
    },
  );
}

class StructureFormDialog extends StatelessWidget {
  const StructureFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StructureFormCubit>();
    
    return AlertDialog(
      title: Text('Crear ${cubit.state.formModel.type.name}'),
      content: BlocBuilder<StructureFormCubit, StructureFormState>(
        builder: (context, state) {
          final titleErrors = state.errorMessage?['title'];
          
          return TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Nombre',
              errorText: titleErrors?.join('\n')
            ),
            onChanged: cubit.titleChanged,
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar')
        ),
        
        BlocBuilder<StructureFormCubit, StructureFormState>(
          builder: (context, state) {
            final isEnable = state.isValid;
            
            return TextButton(
              onPressed: isEnable 
                ? () {
                final structureBloc = context.read<StructureBloc>();
                structureBloc.add(
                  CreateStructure(state.formModel),
                );
                Navigator.of(context).pop();
              }
              : null,
              child: Text('Aceptar')
            );
          },
        ),
      ],
    );
  }
}
// Flutter Imports
import 'package:flutter/material.dart';


import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/widgets/custom_text_field.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/notebook_form_bloc/notebook_form_bloc.dart';



class NotebookEditPage extends StatelessWidget {
  const NotebookEditPage({super.key});

  static Route<void> route({NotebookUiModel? initialNotebook}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => NotebookFormBloc(
          initialNotebook: initialNotebook
        ),
        child: const NotebookEditPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha cambios en el estado de Bloc y cierra la pantalla solo cuando el formulario ha sido enviado con éxito
    return BlocListener<NotebookFormBloc, NotebookFormState>(
      listenWhen: (previous, current) => previous.status != current.status && current.status == NotebookFormStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const NotebookEditView(),
    );
  }
}

class NotebookEditView extends StatelessWidget {
  const NotebookEditView({super.key});

  @override
  Widget build(BuildContext context) {
    // final status = context.select((NotebookFormBloc bloc) => bloc.state.status);
    final isNewTodo = context.select((NotebookFormBloc bloc) => bloc.state.isNewNotebook);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTodo
            ? 'Crear Libreta'
            : 'Editar Libreta'
        ),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 16),
              
              _nameField(context),
              SizedBox(height: 16),
              
              _descriptionField(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _nameField(BuildContext context) {
  return CustomTextField(
    labelText: 'Nombre', 
    hintText: 'Nombre',
    maxLines: 1,
    icon: Icons.article,
    onChanged: (value) => context.read<NotebookFormBloc>().add(NotebookNameChanged(value)), 
    obscureText: false,
  );
}

Widget _descriptionField(BuildContext context) {
  return CustomTextField(
    labelText: 'Descripción', 
    hintText: 'Descripción',
    minLines: 1,
    maxLines: 3,
    icon: Icons.article,
    onChanged: (value) => context.read<NotebookFormBloc>().add(NotebookDescriptionChanged(value)), 
    obscureText: false,
  );
}

//Widget _colorPickerButton(BuildContext context) {
//  final formBloc = context.watch<NotebookFormBloc>();
//  
//  return ElevatedButton(
//    onPressed: () {
//      showDialog(
//        context: context,
//        builder: (context) {
//          return 
//        }
//      );
//    },
//    child: ColorPickerDialog(
//      onColorSelected: (color) {
//        
//      }
//    )
//  );
//}
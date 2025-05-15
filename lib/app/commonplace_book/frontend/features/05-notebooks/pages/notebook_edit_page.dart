// Flutter Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/utils/color_utils.dart';
import 'package:flutter/material.dart';

import 'package:commonplace_book/app/commonplace_book/frontend/features/shared/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../dependency_injection.dart';
import '../state/notebook_bloc/notebook_bloc.dart';
import '../state/notebook_form_bloc/notebook_form_bloc.dart';
import '../widgets/widgets.dart';

class NotebookEditPage extends StatelessWidget {
  const NotebookEditPage({super.key});

  static Route<void> route({NotebookUiModel? initialNotebook}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<NotebookBloc>()),
          BlocProvider<NotebookFormBloc>(create: (_) => NotebookFormBloc(initialNotebook: initialNotebook)),
        ],
        child: const NotebookEditPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha cambios en el estado de Bloc y cierra la pantalla solo cuando el formulario ha sido enviado con éxito
    return BlocListener<NotebookFormBloc, NotebookFormState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == NotebookFormStatus.success,
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
    final formState = context.watch<NotebookFormBloc>().state;
    final isNewNotebook = formState.isNewNotebook;
    final notebook = formState.notebook;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(isNewNotebook ? 'Crear Libreta' : 'Editar Libreta'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _notebookInformation(notebook, isNewNotebook, context),
                
                _nameField(context),
                SizedBox(height: 16),
                
                _descriptionField(context),
                SizedBox(height: 16),
                
                _ColorPickerButton(),
                SizedBox(height: 16),
                
                _createNotebookButton(context, isNewNotebook),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _notebookInformation(NotebookUiModel notebook, bool isNewNotebook, context) {
  if(isNewNotebook) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: NotebookCardDesing(notebook: notebook),
        ),
      ),
    );
  }
  
  else {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: NotebookCardDesing(notebook: notebook),
          ),
          SizedBox(width: 16),
          
          Expanded(
            flex: 2,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fecha de creación',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  notebook.formattedCreatedAt,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 12),
                Text(
                  'Última actualización',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  notebook.formattedUpdatedAt,
                  style: TextStyle(fontSize: 12),
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}


Widget _nameField(BuildContext context) {
  final state = context.watch<NotebookFormBloc>().state;
  final hintText = state.initialNotebook?.name ?? 'Nombre';
  
  final errorText = state.errorMessages?['name'] != null
    ? state.errorMessages!['name']!.join('\n')
    : null;
  
  return CustomTextField(
    enable: !state.status.isLoadingOrSuccess,
    forceErrorText: errorText,
    initialValue: state.notebook.name,
    labelText: 'Nombre',
    hintText: hintText,
    maxLines: 1,
    maxLength: 100,
    icon: Icons.title,
    onChanged: (value) => context.read<NotebookFormBloc>().add(NotebookNameChanged(value)),
    obscureText: false,
  );
}

Widget _descriptionField(BuildContext context) {
  final state = context.watch<NotebookFormBloc>().state;
  final hintText = state.initialNotebook?.description ?? 'Descripción'; 
  
  final errorText = state.errorMessages?['description'] != null
    ? state.errorMessages!['description']!.join('\n')
    : null;
  
  return CustomTextField(
    enable: !state.status.isLoadingOrSuccess,
    forceErrorText: errorText,
    initialValue: state.notebook.description,
    labelText: 'Descripción',
    hintText: hintText,
    minLines: 1,
    maxLines: 5,
    maxLength: 500,
    icon: Icons.subject,
    onChanged: (value) => context.read<NotebookFormBloc>().add(NotebookDescriptionChanged(value)),
    obscureText: false,
  );
}

class _ColorPickerButton extends StatelessWidget {
  const _ColorPickerButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookFormBloc, NotebookFormState>(
      buildWhen: (previous, current) => previous.notebook.color != current.notebook.color,
      builder: (context, state) {
        final currentColor = state.notebook.color.toColor();
        final bloc = context.read<NotebookFormBloc>();

        // Determina si el color de fondo es claro u oscuro
        final brightness = ThemeData.estimateBrightnessForColor(currentColor);
        final isDark = brightness == Brightness.dark;
        final foregroundColor = isDark ? Colors.white : Colors.black87;

        return InkWell(
          onTap: () {
            _showColorPickerDialog(context, (color) {
              final hexColor = colorToHex(color);
              bloc.add(NotebookColorChanged(hexColor));
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.palette, color: foregroundColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Seleccione color',
                    style: TextStyle(fontSize: 16, color: foregroundColor),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  void _showColorPickerDialog(BuildContext context, Function(Color) onColorSelected) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ColorPickerDialog(
          onColorSelected: (color) {
            onColorSelected(color);
          },
        );
      }
    );
  }
}

Widget _createNotebookButton(BuildContext context, bool isNewNotebook) {
  return BlocBuilder<NotebookFormBloc, NotebookFormState>(
    builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          final notebookFormBloc = BlocProvider.of<NotebookFormBloc>(context);
          final notebook = notebookFormBloc.state.notebook;
          
          if(isNewNotebook) {
            // Crear nueva libreta
            context.read<NotebookBloc>().add(CreateNotebook(notebook));
          } else {
            // Actualizar libreta existente
            context.read<NotebookBloc>().add(UpdateNotebook(notebook));
          }
          
          notebookFormBloc.add(const NotebookFormSubmitted());
        }, 
        
        child: Text(isNewNotebook 
          ? 'Crear libreta' 
          : 'Actualizar libreta'
        ),
      );
    },
  );
}
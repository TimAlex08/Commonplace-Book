
import 'package:commonplace_book/app/commonplace_book/frontend/features/02-main_screen/cubit/main_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class MainScreenFAB extends StatelessWidget {
  const MainScreenFAB({
    super.key,
    required this.selectedTab,
  });
  
  final MainScreenTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return  SpeedDial(
        // Tamaño de Botones
        buttonSize: const Size(56, 56),
        childrenButtonSize: const Size(56, 56),
        
        // Configuración de Botones
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 8,
        spaceBetweenChildren: 6,
        
        // Forma cuadrada con bordes redondeados        
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        
        childMargin: const EdgeInsets.symmetric(horizontal: 16),
        children: _getSpeedDialChildren(context, selectedTab),
    );
  }
}

List<SpeedDialChild> _getSpeedDialChildren(BuildContext context, MainScreenTab selectedTab) {
  switch(selectedTab) {
    case MainScreenTab.home:
      return [
        _createNotebook(context),
        _createJournal(context),
        _createTask(context),
      ];
      
    case MainScreenTab.journal:
      return [
        _createJournal(context)
      ];
      
    case MainScreenTab.notebooks:
      return [
        _createNotebook(context)
      ];
      
    case MainScreenTab.tasks:
      return [
        _createTask(context),
        _createProject(context)
      ];
  }
}

SpeedDialChild _createNotebook(BuildContext context) {
  return SpeedDialChild(
    label: 'Crear Libreta',
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    child: const Icon(Icons.note),
    // onTap: () => Navigator.pushNamed(context, AppRoutes.notebookEdit),
  );
}

SpeedDialChild _createJournal(BuildContext context) {
  return SpeedDialChild(
    label: 'Crear Diario',
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    child: const Icon(Icons.note),
  );
}

SpeedDialChild _createTask(BuildContext context) {
  return SpeedDialChild(
    label: 'Crear Tarea',
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    child: const Icon(Icons.note),
  );
}

SpeedDialChild _createProject(BuildContext context) {
  return SpeedDialChild(
    label: 'Crear Proyecto',
    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    child: const Icon(Icons.note),
  );
}
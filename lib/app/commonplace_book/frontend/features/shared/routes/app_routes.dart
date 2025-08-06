// Flutter Imports
import 'package:flutter/material.dart';

// Pages
import '../../02-main_screen/view/main_screen_page.dart';
import '../../05-notebooks/pages/notebook_edit_page.dart';



class AppRoutes {
  // Constantes para nombres de ruta
  static const String mainScreen = '/mainScreen';
  
  // Rutas de Notebook
  static const String notebooks = '/notebooks';
  static const String notebookEdit = '/notebooks/edit';
  static const String notebookDetail = '/notebooks/detail';
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // Rutas principales
      mainScreen: (context) => const MainScreenPage(),
      notebookEdit: (context) => const NotebookEditPage()
    };
  }
}
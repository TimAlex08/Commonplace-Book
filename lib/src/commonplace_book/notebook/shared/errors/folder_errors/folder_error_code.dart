


import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

class FolderErrorCode {
  // Prefijos para identificar la capa de error
  static const String _domainPrefix = 'FLD_DOM';
  // static const String _applicationPrefix = 'FLD_APP';
  static const String _infrastructurePrefix = 'FLD_INF';
  
  // ----- Errores de Dominio ----- //
  // Validaciones de ID
  static const String invalidId = '${_domainPrefix}_001';
  
  // Validaciones de nombre
  static const String invalidName = '${_domainPrefix}_002';   // Sirve para el nombre vacío, nulo o caracteres inválidos
  static const String nameTooLong = '${_domainPrefix}_003';
  
  
  // ----- Errores de Infrastructura ----- //
  // Errores de conexión
  static const String dbConnectionFailed = '${_infrastructurePrefix}_001';
  static const String dbInitializationFailed = '${_infrastructurePrefix}_002';
  
  // Errores CRUD
  static const String insertFailed = '${_infrastructurePrefix}_003';
  static const String updateFailed = '${_infrastructurePrefix}_004';
  static const String deleteFailed = '${_infrastructurePrefix}_005';
  static const String readFailed = '${_infrastructurePrefix}_006';
  static const String queryFailed = '${_infrastructurePrefix}_007';
}



class FolderErrorMessages {
  static String getMessage(String code) {
    final messages = {
      // ----- Errores de Dominio ----- //
      // Validaciones básicas
      FolderErrorCode.invalidId: 'The folder ID is invalid.',
      FolderErrorCode.invalidName: 'The folder name is invalid.',
      FolderErrorCode.nameTooLong: 'The folder name must have a maximum of ${NotebookConstants.maxFolderNameLength} characters',
      
      
      // ----- Errores de Infrastructura ----- //
      // Errores de conexión
      FolderErrorCode.dbConnectionFailed: 'Failed to connect to the database.',
      FolderErrorCode.dbInitializationFailed: 'Failed to initialize the database.',
      
      // Errores CRUD
      FolderErrorCode.insertFailed: 'Failed to insert the notebook.',
      FolderErrorCode.updateFailed: 'Failed to update the notebook.',
      FolderErrorCode.deleteFailed: 'Failed to delete the notebook.',
      FolderErrorCode.readFailed: 'Failed to read the notebook.',
      FolderErrorCode.queryFailed: 'Failed to query the notebook.',
    };
    
    return messages[code] ?? 'Unknown error';
  }
}
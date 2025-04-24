// Constants
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

class NotebookErrorCode {
  // Prefijos para identificar la capa de error
  static const String _domainPrefix = 'NB_DOM';
  // static const String _applicationPrefix = 'NB_APP';
  static const String _infrastructurePrefix = 'NB_INF';
  
  /// ----- Errores de Dominio ----- ///
  // Validaciones de ID
  static const String invalidId = '${_domainPrefix}_001';
  
  // Validaciones de nombre
  static const String invalidName = '${_domainPrefix}_002';   // Sirve para el nombre vacío, nulo o caracteres inválidos
  static const String nameTooLong = '${_domainPrefix}_003';
  
  // Validaciones de descripción
  static const String descriptionTooLong = '${_domainPrefix}_004';
  
  // Validaciones de fechas
  static const String invalidCreatedAt = '${_domainPrefix}_005';
  static const String invalidUpdatedAt = '${_domainPrefix}_006';
  static const String updatedBeforeCreated = '${_domainPrefix}_007';
  
  // Validaciones de apariencia
  static const String invalidColor = '${_domainPrefix}_008';
  static const String invalidColorFormat = '${_domainPrefix}_009';
  static const String invalidCoverImage = '${_domainPrefix}_010';
  static const String invalidBackCoverImage = '${_domainPrefix}_011';
  
  // Validaciones de estado
  static const String invalidFavoriteValue = '${_domainPrefix}_012';
  static const String invalidArchivedValue = '${_domainPrefix}_013';
  static const String invalidLockedValue = '${_domainPrefix}_014';
  static const String favoriteAndArchivedConflict = '${_domainPrefix}_015';
  
  
  
  /// ----- Errores de Infrastructura ----- ///
  // Errores de conexión
  static const String dbConnectionFailded = '${_infrastructurePrefix}_001';
  static const String dbInitializationFailed = '${_infrastructurePrefix}_002';
  
  // Errores CRUD
  static const String insertFailed = '${_infrastructurePrefix}_003';
  static const String updateFailed = '${_infrastructurePrefix}_004';
  static const String deleteFailed = '${_infrastructurePrefix}_005';
  static const String readFailed = '${_infrastructurePrefix}_006';
  static const String queryFailed = '${_infrastructurePrefix}_007';
}

class NotebookErrorMessages {
  static String getMessage(String code) {
    final messages = {
      // Validaciones básicas
      NotebookErrorCode.invalidId: 'The notebook ID is invalid.',
      NotebookErrorCode.invalidName: 'The notebook name is invalid.',
      NotebookErrorCode.nameTooLong: 'The notebook name must have a maximum of ${NotebookConstants.maxNotebookNameLength} characters.',
      NotebookErrorCode.descriptionTooLong: 'The notebook description must have a maximum of ${NotebookConstants.maxNotebookDescriptionLength} characters.',
      
      // Validaciones de fechas
      NotebookErrorCode.invalidCreatedAt: 'The creation date is invalid.',
      NotebookErrorCode.invalidUpdatedAt: 'The update date is invalid.',
      NotebookErrorCode.updatedBeforeCreated: 'The update date cannot be before the creation date.',
      
      // Validaciones de apariencia
      NotebookErrorCode.invalidColor: 'The notebook color is invalid.',
      NotebookErrorCode.invalidColorFormat: 'The color format is invalid.',
      NotebookErrorCode.invalidCoverImage: 'The cover image has an invalid format.',
      NotebookErrorCode.invalidBackCoverImage: 'The back cover image has an invalid format.',
      
      // Validaciones de estado
      NotebookErrorCode.invalidFavoriteValue: 'The favorite value is invalid.',
      NotebookErrorCode.invalidArchivedValue: 'The archived value is invalid.',
      NotebookErrorCode.invalidLockedValue: 'The locked value is invalid.',
      NotebookErrorCode.favoriteAndArchivedConflict: 'The notebook cannot be both favorite and archived at the same time.',
    };
    
    return messages[code] ?? 'Unknown error';
  }
}
// Constants
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';



class PageErrorCode {
  // Prefijos para identificar la capa de error
  static const String _domainPrefix = 'PG_DOM';
  static const String _infrastructurePrefix = 'PG_INF';

  // ----- Errores de Dominio ----- //
  // Validaciones de ID
  static const String invalidId = '${_domainPrefix}_001';

  // Validaciones de título
  static const String invalidTitle = '${_domainPrefix}_002'; // Nulo, vacío o con caracteres inválidos
  static const String titleTooLong = '${_domainPrefix}_003';

  // Validaciones de fechas
  static const String invalidCreatedAt = '${_domainPrefix}_004';
  static const String invalidUpdatedAt = '${_domainPrefix}_005';
  static const String updatedBeforeCreated = '${_domainPrefix}_006';


  // ----- Errores de Infrastructura ----- //
  static const String dbConnectionFailed = '${_infrastructurePrefix}_001';
  static const String dbInitializationFailed = '${_infrastructurePrefix}_002';

  static const String insertFailed = '${_infrastructurePrefix}_003';
  static const String updateFailed = '${_infrastructurePrefix}_004';
  static const String deleteFailed = '${_infrastructurePrefix}_005';
  static const String readFailed = '${_infrastructurePrefix}_006';
  static const String queryFailed = '${_infrastructurePrefix}_007';
}

class PageErrorMessages {
  static String getMessage(String code) {
    final messages = {
      // ----- Errores de Dominio ----- //
      // Validaciones básicas
      PageErrorCode.invalidId: 'The page ID is invalid.',
      PageErrorCode.invalidTitle: 'The page title is invalid.',
      PageErrorCode.titleTooLong: 'The page title must have a maximum of ${NotebookConstants.maxPageTitleLength} characters.',
      
      // Validaciones de fechas
      PageErrorCode.invalidCreatedAt: 'The creation date is invalid.',
      PageErrorCode.invalidUpdatedAt: 'The update date is invalid.',
      PageErrorCode.updatedBeforeCreated: 'The update date cannot be before the creation date.',


      // ----- Errores de Infrastructura ----- //
      // Errores de conexion
      PageErrorCode.dbConnectionFailed: 'Failed to connect to the database.',
      PageErrorCode.dbInitializationFailed: 'Failed to initialize the database.',
      
      // Errores CRUD
      PageErrorCode.insertFailed: 'Failed to insert the page.',
      PageErrorCode.updateFailed: 'Failed to update the page.',
      PageErrorCode.deleteFailed: 'Failed to delete the page.',
      PageErrorCode.readFailed: 'Failed to read the page.',
      PageErrorCode.queryFailed: 'Failed to query the pages.',
    };

    return messages[code] ?? 'Unknown error';
  }
}
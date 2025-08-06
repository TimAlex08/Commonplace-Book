


class StructureErrorCode {
  // Prefijos para identificar la capa de error
  static const String _domainPrefix = 'STR_DOM';
  static const String _applicationPrefix = 'STR_APP';
  static const String _infrastructurePrefix = 'STR_INF';
  
  // ----- Errores de Dominio ----- //
  // Validaciones de ID
  static const String invalidStructureId = '${_domainPrefix}_001';
  static const String invalidNotebookIdReference = '${_domainPrefix}_002';
  static const String invalidParentId = '${_domainPrefix}_003';
  static const String invalidStructureType = '${_domainPrefix}_004';
  static const String invalidFolderIdReference = '${_domainPrefix}_005';
  static const String invalidPageIdReference = '${_domainPrefix}_006';
  
  // Ambos FolderId y PageId son nulos
  static const String inconsistentContentReference = '${_domainPrefix}_007';
  
  // El padre no puede ser una página
  static const String parentCannotBePage = '${_domainPrefix}_008';
  
  // Posición fuera de rango (negativa)
  static const String invalidPosition = '${_domainPrefix}_009';
  
  // Profundidad fuera de rango (negativa o muy alta)
  static const String invalidDepth = '${_domainPrefix}_010';
  
  // Restricción lógica rota (por ejemplo, padre inválido por estructura)
  static const String inconsistentHierarchy = '${_domainPrefix}_011';
  
  
  // ----- Errores de Aplicación ----- //
  static const String notebookIdNotFound = '${_applicationPrefix}_001';
  static const String structureIdNotFound = '${_applicationPrefix}_002';
  static const String parentIdNotFound = '${_applicationPrefix}_003';
  static const String structureDoesNotBelongToNotebook = '${_applicationPrefix}_004';
  static const String structureReorderFailed = '${_applicationPrefix}_005';
  static const String structureMovedFailed = '${_applicationPrefix}_006';
  static const String circularReference = '${_applicationPrefix}_007';

  
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

class StructureErrorMessages {
  static String getMessage(String code) {
    final messages = {
      // ----- Errores de Dominio ----- //
      // Validaciones básicas
      StructureErrorCode.invalidStructureId: 'The structure ID is invalid.',
      StructureErrorCode.invalidParentId: 'The parent ID is invalid.',
      StructureErrorCode.invalidNotebookIdReference: 'The notebook reference is invalid.',
      StructureErrorCode.invalidStructureType: 'The structure type is invalid.',
      StructureErrorCode.invalidFolderIdReference: 'The folder reference is invalid.',
      StructureErrorCode.invalidPageIdReference: 'The page ID reference invalid.',
      
      // Validaciones estructurales de la jerarquía
      StructureErrorCode.inconsistentContentReference: 'Both FolderId and PageId are invalid.',
      StructureErrorCode.parentCannotBePage: 'The parent cannot be a page.',
      StructureErrorCode.invalidPosition: 'The position is out of range (negative).',
      StructureErrorCode.invalidDepth: 'The depth is out of range (negative or too high).',
      StructureErrorCode.inconsistentHierarchy: 'Logical constraint broken.',
      
      
      // ----- Errores de Aplicación ----- //
      StructureErrorCode.structureIdNotFound: 'The structure was not found.',
      StructureErrorCode.notebookIdNotFound: 'The notebook was not found.',
      StructureErrorCode.parentIdNotFound: 'The parent ID was not found.',
      StructureErrorCode.structureDoesNotBelongToNotebook: 'The structure does not belong to the notebook.',
      StructureErrorCode.structureReorderFailed: 'Failed to reorder the structure item.',
      StructureErrorCode.structureMovedFailed: 'Failed to move the structure item.',
      StructureErrorCode.circularReference: 'Circular reference detected.',
      
      
      // ----- Errores de Infrastructura ----- //
      // Errores de conexión
      StructureErrorCode.dbConnectionFailed: 'Failed to connect to the database.',
      StructureErrorCode.dbInitializationFailed: 'Failed to initialize the database.',
      
      // Errores CRUD
      StructureErrorCode.insertFailed: 'Failed to insert the notebook.',
      StructureErrorCode.updateFailed: 'Failed to update the notebook.',
      StructureErrorCode.deleteFailed: 'Failed to delete the notebook.',
      StructureErrorCode.readFailed: 'Failed to read the notebook.',
      StructureErrorCode.queryFailed: 'Failed to query the notebook.',

    };
    
    return messages[code] ?? 'Unknown error code.';
  }
}
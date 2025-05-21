

class StructureErrorCode {
  // Prefijos para identificar la capa de error
  static const String _domainPrefix = 'STR_DOM';
  static const String _applicationPrefix = 'STR_APP';
  static const String _infrastructurePrefix = 'STR_INF';
  
  // ----- Eventos de Dominio ----- //
  // Validaciones de ID
  static const String invalidStructureId = '${_domainPrefix}_001';
  static const String invalidParentId = '${_domainPrefix}_002';
  static const String invalidNotebookReference = '${_domainPrefix}_003';
  static const String invalidFolderReference = '${_domainPrefix}_004';
  static const String invalidPageReference = '${_domainPrefix}_005';
  
  // Ambos FolderId y PageId son nulos
  static const String missingContentReference = '${_domainPrefix}_006';
  
  // El padre no puede ser una página
  static const String parentCannotBePage = '${_domainPrefix}_007';
  
  // Posición fuera de rango (negativa)
  static const String invalidPosition = '${_domainPrefix}_008';
  
  // Profundidad fuera de rango (negativa o muy alta)
  static const String invalidDepth = '${_domainPrefix}_009';
  
  // Restricción lógica rota (por ejemplo, padre inválido por estructura)
  static const String inconsistentHierarchy = '${_domainPrefix}_010';
  
  
  // ----- Errorres de Aplicación ----- //
  static const String notebookNotFound = '${_applicationPrefix}_001';
  static const String structureAlreadyExists = '${_applicationPrefix}_002';            
  static const String structureDoesNotBelongToNotebook = '${_applicationPrefix}_003';
  static const String circularReference = '${_applicationPrefix}_004';
  static const String nodeAlreadyExists = '${_applicationPrefix}_005';
  
  
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
      StructureErrorCode.invalidNotebookReference: 'The notebook reference is invalid.',
      StructureErrorCode.invalidFolderReference: 'The folder reference is invalid.',
      StructureErrorCode.invalidPageReference: 'The page ID reference invalid.',
      
      // Validaciones estructurales de la jerarquía
      StructureErrorCode.missingContentReference: 'Both FolderId and PageId are invalid.',
      StructureErrorCode.parentCannotBePage: 'The parent cannot be a page.',
      StructureErrorCode.invalidPosition: 'The position is out of range (negative).',
      StructureErrorCode.invalidDepth: 'The depth is out of range (negative or too high).',
      StructureErrorCode.inconsistentHierarchy: 'Logical constraint broken.',
      
      
      // ----- Errores de Aplicación ----- //
      StructureErrorCode.notebookNotFound: 'The notebook was not found.',
      StructureErrorCode.structureAlreadyExists: 'The structure already exists.',
      StructureErrorCode.structureDoesNotBelongToNotebook: 'The structure does not belong to the notebook.',
      StructureErrorCode.circularReference: 'Circular reference detected.',
      StructureErrorCode.nodeAlreadyExists: 'The node already exists.',
      
      
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
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_error_codes.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



enum MessageType { error, success }

class UserMessage {
  const UserMessage({
    required this.title, 
    required this.message,
    this.type = MessageType.success
  });
  
  final String title;
  final String message;
  final MessageType type;
  
  /// UserMessage.Error: Constructor para crear mensajes de error
  factory UserMessage.error({
    required String title,
    required String message,
  }) {
    return UserMessage(
      title: title, 
      message: message,
      type: MessageType.error
    );  
  }
  
  /// UserMessage.Success: Constructor para crear mensajes de éxito
  factory UserMessage.success({
    required String title,
    required String message
  }) {
    return UserMessage(
      title: title, 
      message: message,
      type: MessageType.success
    );
  }
}



class UserErrorMapper {
  static UserMessage mapList(List<Failure> failures) {
    if(failures.isEmpty) {
      return UserMessage.error(
        title: 'Error desconocido', 
        message: 'Ocurrió un error inesperado'
      );
    }
    
    // Toma `List<Failures>` y las clasifica por tipo de errores
    final domainFailures = failures.where(_isDomainFailure).cast<DomainFailure>().toList();
    final infrastructureFailures = failures.where(_isInfrastructureFailure).cast<InfrastructureFailure>().toList();
    
    // Errores de dominio
    if(domainFailures.isNotEmpty && infrastructureFailures.isEmpty) {
      final messages = domainFailures.map(_mapDomainFailure).toSet().toList();
      
      return UserMessage.error(
        title: 'No se pudo crear la libreta', 
        message: 'Corrige los siguientes errores:\n• ${messages.join('\n• ')} '
      );
    }
    
    // Errores de Infrastructura
    if(infrastructureFailures.isNotEmpty && domainFailures.isEmpty) {
      final messages = infrastructureFailures.map(_mapInfrastructureFailure).toSet().toList();
      
      return UserMessage.error(
        title: 'Error técnico', 
        message: 'Ocurrieron los siguientes problemas:\n• ${messages.join('\n• ')}'
      );
    }
    
    // Errores mixtos o desconocidos
    return UserMessage.error(
      title: 'Error inesperado', 
      message: 'Se produjeron distintos tipos de errores. Intenta de nuevo o contacta soporte'
    );
  }
  
  /// MapSuccess: Crea mensajes de éxito basados en la operación realizada
  static UserMessage mapSuccess(String operation) {
    switch(operation) {
      case 'create':
        return UserMessage.success(
          title: 'Libreta creada', 
          message: 'Tu libreta ha sido creada exitosamente'
        );
        
      case 'update':
        return UserMessage.success(
          title: 'Libreta actualizada', 
          message: 'Los cambios en tu libreta han sido guardados'
        );
        
      case 'delete':
        return UserMessage.success(
          title: 'Libreta eliminada', 
          message: 'La libreta ha sido eliminada correctamente'
        );
        
      default:
        return UserMessage.success(
          title: 'Operación completada', 
          message: 'La operación se realizó correctamente'
        );
    }
  }
  
  /// MapDomainFailure: Mappea los errores de dominio
  static String _mapDomainFailure(DomainFailure failure) {
    switch (failure.code) {
      case NotebookErrorCode.invalidName:
        return 'El nombre que ingresaste no es válido.';
      case NotebookErrorCode.nameTooLong:
        return 'El nombre es demasiado largo.';
      case NotebookErrorCode.descriptionTooLong:
        return 'La descripción es demasiado larga.';
      default:
        return 'Hay datos inválidos en la libreta.';
    }
  }

  /// MapInfrastructureFailure: Mappea los errores de infrastructura
  static String _mapInfrastructureFailure(InfrastructureFailure failure) {
    switch (failure.code) {
      case NotebookErrorCode.dbConnectionFailded:
      case NotebookErrorCode.dbInitializationFailed:
        return 'No pudimos acceder a la base de datos. Revisa tu conexión o reinicia la app.';
      case NotebookErrorCode.insertFailed:
      case NotebookErrorCode.updateFailed:
      case NotebookErrorCode.deleteFailed:
      case NotebookErrorCode.readFailed:
      case NotebookErrorCode.queryFailed:
        return 'Ocurrió un error al guardar o cargar tus datos. Intenta de nuevo.';
      default:
        return 'Hubo un problema técnico. Estamos trabajando para solucionarlo.';
    }
  }

  // Determina que tipo de error es
  static bool _isDomainFailure(Failure f) => f.code.startsWith('NB_DOM');
  static bool _isInfrastructureFailure(Failure f) => f.code.startsWith('NB_INF');
}
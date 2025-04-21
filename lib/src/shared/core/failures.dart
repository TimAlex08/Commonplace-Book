import 'package:logger/logger.dart';

abstract class Failure {
  final String code;
  final String message;
  final String? details;
  
  const Failure({
    required this.message, 
    required this.code, 
             this.details
  });
  
  /// Logger para registrar errores
  static final Logger _logger = Logger();
  
  /// Método para registrar el error en la consola
  void logError() {
    final String layerPrefix = 
        this is DomainFailure ? 'DOMAIN' : 
        this is ApplicationFailure ? 'APPLICATION' :
        this is InfrastructureFailure ? 'INFRASTRUCTURE' : 'GENERAL';
    
    _logger.e('[$layerPrefix] Error ($code): $message. Details: $details');
  }
  
  @override
  String toString() => '${runtimeType.toString()}: (code: $code): Message: $message, Details: $details)';
}

abstract class DomainFailure extends Failure {
  const DomainFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

abstract class ApplicationFailure extends Failure {
  const ApplicationFailure({
    required super.message,
    required super.code,
    super.details,
  });
}

abstract class InfrastructureFailure extends Failure {
  const InfrastructureFailure({
    required super.message,
    required super.code,
    super.details,
  });
}
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:logger/logger.dart';



/// ValidationResult: Representa el resultado de un proceso de validación, conteniendo
/// la entidad genérica `T` validada (cuando es válida) o un `List<Failure>` (cuando no lo es).
class ValidationResult<T> {
  ValidationResult({
    this.entity, 
    this.failures = const [], 
  });
  
  final T? entity;
  final List<Failure> failures;
  
  bool get isValid => failures.isEmpty;
  
  factory ValidationResult.success(T entity) {
    return ValidationResult(entity: entity, failures: []);
  } 
  
  factory ValidationResult.failure(List<Failure> failures) {
    return ValidationResult(failures: failures);
  }
  
  void logFailures() {
    if(failures.isEmpty) return;
    
    String entityType = entity != null
      ? entity.runtimeType.toString().toUpperCase()
      : 'ENTITY';
      
    final logger = Logger();
    
    // Agrupa los errores por capa (Domain, Application, Infrastructure)
    final domainFailures = failures.whereType<DomainFailure>().toList();
    final applicationFailures = failures.whereType<ApplicationFailure>().toList();
    final infrastructureFailures = failures.whereType<InfrastructureFailure>().toList();
    
    if(domainFailures.isNotEmpty) {
      logger.e('DOMAIN ERROR - $entityType VALIDATION');
      for(var failure in domainFailures) {
        logger.e('- DOMAIN ${failure.code}. Message: ${failure.message}'
          '${failure.details != null ? '. Details: ${failure.details}' : ''}');
      }
    }
    
    if(applicationFailures.isNotEmpty) {
      logger.e('APPLICATION ERROR - $entityType PROCESSING');
      for(var failure in applicationFailures) {
        logger.e('- APPLICATION ${failure.code}. Message: ${failure.message}'
          '${failure.details != null ? '. Details: ${failure.details}' : ''}');
      }
    }
    
    if(infrastructureFailures.isNotEmpty) {
      logger.e('INFRASTRUCTURE ERROR - $entityType PERSISTENCE');
      for(var failure in infrastructureFailures) {
        logger.e('- INFRASTRUCTURE ${failure.code}. Message: ${failure.message}'
          '${failure.details != null ? '. Details: ${failure.details}' : ''}');
      }
    }
  }
}
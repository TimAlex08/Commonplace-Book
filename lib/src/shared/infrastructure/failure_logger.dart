// External Imports
import 'package:logger/logger.dart';

// Failures
import 'package:commonplace_book/src/shared/core/failures.dart';


final _logger = Logger();

void logFailure(List<Failure> failures, [StackTrace? stack]) {
  for(final failure in failures) {
    final logString = failure.toString();
    
    if(failure is DomainFailure) {
      _logger.w(logString);
    } else if(failure is ApplicationFailure) {
      _logger.w(logString, stackTrace: stack);
    } else if(failure is InfrastructureFailure) {
      _logger.w(logString, stackTrace: stack);
    } else {
      _logger.w('UNKNOWN FAILURE', stackTrace: stack);
    }
  }
}
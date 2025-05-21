// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_error_code.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



/// ----- Errores de Conexión ----- ///
class StructureDBConnectionFailure extends InfrastructureFailure {
  StructureDBConnectionFailure({super.details}) : super(
    code : StructureErrorCode.dbConnectionFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.dbConnectionFailed),
  );
}

class StructureDBInitializationFailure extends InfrastructureFailure {
  StructureDBInitializationFailure({super.details}) : super(
    code: StructureErrorCode.dbInitializationFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.dbInitializationFailed),
  );
}



/// ----- Errores CRUD ----- ///
class StructureInsertFailure extends InfrastructureFailure {
  StructureInsertFailure({super.details}) : super(
    code: StructureErrorCode.insertFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.insertFailed),
  );
}

class StructureUpdateFailure extends InfrastructureFailure {
  StructureUpdateFailure({super.details}) : super(
    code:StructureErrorCode.updateFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.updateFailed),
  );
}

class StructureDeleteFailure extends InfrastructureFailure {
  StructureDeleteFailure({super.details}) : super(
    code: StructureErrorCode.deleteFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.deleteFailed),
  );
}

class StructureReadFailure extends InfrastructureFailure {
  StructureReadFailure({super.details}) : super(
    code: StructureErrorCode.readFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.readFailed),
  );
}

class StructureQueryFailure extends InfrastructureFailure {
  StructureQueryFailure({super.details}) : super(
    code: StructureErrorCode.queryFailed,
    message: StructureErrorMessages.getMessage(StructureErrorCode.queryFailed),
  );
}
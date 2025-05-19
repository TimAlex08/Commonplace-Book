// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_errors/notebook_error_codes.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



// ----- Errores de ID ----- //
class NotebookInvalidIdFailure extends DomainFailure {
  NotebookInvalidIdFailure({super.details}) : super(
    code: NotebookErrorCode.invalidId,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidId),
  );
}



// ----- Errores de Nombre ----- //
class NotebookInvalidNameFailure extends DomainFailure {
  NotebookInvalidNameFailure({super.details}) : super(
    code: NotebookErrorCode.invalidName,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidName),
  );
}

class NotebookNameTooLongFailure extends DomainFailure {
  NotebookNameTooLongFailure({super.details}) : super(
    code: NotebookErrorCode.nameTooLong,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.nameTooLong)
  );
}



// ----- Errores de Descripción ----- //
class NotebookDescriptionTooLongFailure extends DomainFailure {
  NotebookDescriptionTooLongFailure({super.details}) : super(
    code: NotebookErrorCode.descriptionTooLong,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.descriptionTooLong),
  );
}



// ----- Errores de Fechas ----- //
class NotebookInvalidCreatedAtFailure extends DomainFailure {
  NotebookInvalidCreatedAtFailure({super.details}) : super(
    code: NotebookErrorCode.invalidCreatedAt,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidCreatedAt),
  );
}

class NotebookInvalidUpdatedAtFailure extends DomainFailure {
  NotebookInvalidUpdatedAtFailure({super.details}) : super(
    code: NotebookErrorCode.invalidUpdatedAt,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidUpdatedAt),
  );
}

class NotebookUpdatedBeforeCreatedFailure extends DomainFailure {
  NotebookUpdatedBeforeCreatedFailure({super.details}) : super(
    code: NotebookErrorCode.updatedBeforeCreated,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.updatedBeforeCreated),
  );
}



// ----- Errores de Apariencia ----- //
class NotebookInvalidColorFailure extends DomainFailure {
  NotebookInvalidColorFailure({super.details}) : super(
    code: NotebookErrorCode.invalidColor,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidColor),
  );
}

class NotebookColorFormatFailure extends DomainFailure {
  NotebookColorFormatFailure({super.details}) : super(
    code: NotebookErrorCode.invalidColorFormat,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidColorFormat),
  );
}

class NotebookInvalidCoverImageFailure extends DomainFailure {
  NotebookInvalidCoverImageFailure({super.details}) : super(
    code: NotebookErrorCode.invalidCoverImage,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidCoverImage),
  );
}

class NotebookInvalidBackCoverImageFailure extends DomainFailure {
  NotebookInvalidBackCoverImageFailure({super.details}) : super(
    code: NotebookErrorCode.invalidBackCoverImage,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidBackCoverImage),
  );
}



// ----- Errores de Estado ----- //
class NotebookInvalidFavoriteValueFailure extends DomainFailure {
  NotebookInvalidFavoriteValueFailure({super.details}) : super(
    code: NotebookErrorCode.invalidFavoriteValue,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidFavoriteValue),
  );
}

class NotebookInvalidArchivedValueFailure extends DomainFailure {
  NotebookInvalidArchivedValueFailure({super.details}) : super(
    code: NotebookErrorCode.invalidArchivedValue,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidArchivedValue),
  );
}

class NotebookInvalidLockedValueFailure extends DomainFailure {
  NotebookInvalidLockedValueFailure({super.details}) : super(
    code: NotebookErrorCode.invalidLockedValue,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.invalidLockedValue),
  );
}

class NotebookFavoriteAndArchivedConflictFailure extends DomainFailure {
  NotebookFavoriteAndArchivedConflictFailure({super.details}) : super(
    code: NotebookErrorCode.favoriteAndArchivedConflict,
    message: NotebookErrorMessages.getMessage(NotebookErrorCode.favoriteAndArchivedConflict),
  );
}
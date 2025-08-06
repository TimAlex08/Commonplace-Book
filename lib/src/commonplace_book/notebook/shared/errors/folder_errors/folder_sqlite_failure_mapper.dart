// External Imports
import 'package:drift/native.dart';

// Failures
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/folder_errors/folder_infrastructure_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';



class FolderSqliteFailureMapper {
  static Failure map(SqliteException e, Failure baseFailure) {
    switch (e.extendedResultCode) {
      // Constraints violations.
      case 2067:
        return FolderInsertFailure(details: "SQLITE(${e.extendedResultCode}): Unique key violated. ${e.message}");
      case 1555: // SQLITE_CONSTRAINT_PRIMARYKEY.
        return FolderInsertFailure(details: "SQLITE(${e.extendedResultCode}): Primary key violation. ${e.message}");
      case 787: // SQLITE_CONSTRAINT_FOREIGNKEY.
        return FolderInsertFailure(details: "SQLITE(${e.extendedResultCode}): Foreing key violation. ${e.message}");
      case 1299:
        return FolderInsertFailure(details: "SQLITE(${e.extendedResultCode}): Empty NOT NULL field. ${e.message}");
        
      // Data errors.
      case 20:
        return FolderInsertFailure(details: "SQLITE(${e.extendedResultCode}): Invalid data type. ${e.message}");
        
      // I/O Connection errors.
      case 6:  // SQLITE_LOCKED.
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): The database is busy. ${e.message}");
      case 261: // SQLITE_IOERR.
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): I/O error. ${e.message}");
      case 11: // SQLITE_CORRUPT.
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): Database file has been corrupted. ${e.message}");
      case 10: // SQLITE_IOERR_LOCK.
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): Crash error. ${e.message}");
      case 14: // SQLITE_CANT_OPEN.
        return FolderDBInitializationFailure(details: "SQLITE(${e.extendedResultCode}): The database cannot be opened. ${e.message}");
      
      // Permisision / Configuration.
      case 8:
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): The database is read-only. ${e.message}");
      case 21:
        return FolderDBConnectionFailure(details: "SQLITE(${e.extendedResultCode}): Incorrect use of the database. ${e.message}");
      
      default:
        return baseFailure;
    }
  }
}
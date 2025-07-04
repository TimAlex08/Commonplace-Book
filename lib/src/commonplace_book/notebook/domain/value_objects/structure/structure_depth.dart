// Constants.
import 'package:commonplace_book/src/shared/core/notebook_constants.dart';

// Failures / Result.
import 'package:commonplace_book/src/commonplace_book/notebook/shared/errors/notebook_structure_errors/structure_domain_failures.dart';
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';



enum StructureItemType {folder, page}

/// StructureDepth: Objeto de valor que valida la profundidad de un elemento en la estructura del libreta.
/// - Valida que no sea nulo ni menor a 0.
class StructureDepth {
  const StructureDepth._(this.value);
  final int value;

  static const int maxFolderDepth = NotebookConstants.maxFolderDepth;
  static const int maxPageDepth = NotebookConstants.maxPageDepth;

  static Result<StructureDepth, List<DomainFailure>> validateFolder(int? depth) {
    return _validate(
      depth: depth,
      max: maxFolderDepth,
      type: StructureItemType.folder
    );
  }

  static Result<StructureDepth, List<DomainFailure>> validatePage(int? depth) {
    return _validate(
      depth: depth,
      max: maxPageDepth,
      type: StructureItemType.page
    );
  }

  static Result<StructureDepth, List<DomainFailure>> _validate({
    required int? depth,
    required int max,
    required StructureItemType type
  }) {
    final failures = <DomainFailure>[];
    final label = type == StructureItemType.folder ? 'Folder' : 'Page';

    if (depth == null) {
      failures.add(StructureInvalidDepthFailure(details: 'Depth cannot be null.'));
    } else {
      if (depth < 0) {
        failures.add(StructureInvalidDepthFailure(details: '$label depth must be >= 0.'));
      }
      if (depth > max) {
        failures.add(StructureInvalidDepthFailure(details: '$label depth must be <= $max.'));
      }
    }

    return failures.isEmpty
      ? Result.success(StructureDepth._(depth!))
      : Result.failure(failures);
  }
}
// Failures / Result.
import 'package:commonplace_book/src/shared/core/failures.dart';
import 'package:commonplace_book/src/shared/core/result.dart';

// Value Objects.
import 'package:commonplace_book/src/commonplace_book/notebook/domain/value_objects/page/page_vo.dart';



/// Page: Representa la entidad de una página dentro de una libreta en la aplicación.
class Page {
  const Page._({
    required this.id,
    required this.title,
    required this.timestamp,
  });
  
  final PageId id;
  final PageTitle title;
  final PageTimestamp timestamp;
  
  static Result<Page, List<DomainFailure>> create(PageParams params) {
    final failures = <DomainFailure>[];
    
    // ----- Validaciones de parámetros ----- //
    final idResult = PageId.validate(params.id);
    final titleResult = PageTitle.validate(params.title);
    final timestamtpResult = PageTimestamp.validate(createdAt: params.createdAt, updatedAt: params.updatedAt);
    
    // ----- Acumular errores si hay fallos en la validaciones ----- //
    if (idResult.isFailure) failures.addAll(idResult.getFailure());
    if (titleResult.isFailure) failures.addAll(titleResult.getFailure());
    if (timestamtpResult.isFailure) failures.addAll(timestamtpResult.getFailure());
    
    // Si hay errores, devuelve una lista de fallos.
    if (failures.isNotEmpty) return Result.failure(failures);
    
    // Si no hay errores, crea un objeto válido Page.
    return Result.success(Page._(
      id: idResult.getSuccess(), 
      title: titleResult.getSuccess(),
      timestamp: timestamtpResult.getSuccess()
    ));
  }
}



/// PageParams: Clase que representa los parámetros necesarios para crear un `Page`.
class PageParams {
  const PageParams({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt
  });
  
  final String? id;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
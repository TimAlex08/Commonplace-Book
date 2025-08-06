class Result<S, F> {
  Result._({
    S? success,
    F? failure,
    required this.isSuccess,    
  }) :  _success = success,
        _failure = failure;
  
  final S? _success;            // S Representa el tipo de éxito
  final F? _failure;            // F Representa el tipo de fallo
  final bool isSuccess;         // Indica si el resultado es exitoso o fallido
  
  /// Crea un resultado exitoso con un valor
  factory Result.success(S value) {
    return Result._(success: value, failure: null, isSuccess: true);
  }
  
  /// Crea un resultado fallido con un valor
  factory Result.failure(F value) {
    return Result._(success: null, failure: value, isSuccess: false);
  }
  
  /// Getter que devuelve el opuesto de isSuccess.
  bool get isFailure => !isSuccess;
  
  /// Extrae el valor correspondiente (Éxito).
  /// Validan que el estado sea coherente antes de devolver el valor.
  /// Lanza una excepción si se intenta acceder a un valor del tipo incorrecto.
  S getSuccess() {
    if(isSuccess && _success != null) {
      return _success;
    } else {
      throw StateError('Cannot get success value from a failure result');
    }
  }
  
  /// Extrae el valor correspondiente (Fallo).
  /// Validan que el estado sea coherente antes de devolver el valor.
  /// Lanza una excepción si se intenta acceder a un valor del tipo incorrecto.
  F getFailure() {
    if(isFailure && _failure != null) {
      return _failure;
    } else {
      throw StateError('Cannot get failure value from a success result');
    }
  }
  
  /// Ejecuta una de las funciones según el resultado
  /// - [onSuccess]: Función a ejecutar si hay éxito (Usa el valor de `success`).
  /// - [onFailure]: Función a ejecutar si hay fallo (Usa el valor de `failure`).
  /// 
  /// Retorna el valor devuelto por la función correspondiente.
  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    if (isSuccess) {
      return onSuccess(_success as S);
    } else {
      return onFailure(_failure as F);
    }
  }
  
  /// ----- Railway Oriented Programming ----- ///
  
  /// Transforma el valor del éxito usando la función [mapper] proporcinada.
  /// 
  /// Si este Result es un éxito, aplica [mapper] al valor exitoso y devuelve
  /// un nuevo Result.success con el valor transformado.
  /// Si este Result es un fallo, devuelve un nuevo Result.failure con el mismo
  /// valor de fallo original.
  ///
  /// El tipo de éxito cambia de [S] a [U], mientras que el tipo de fallo [F] se mantiene.
  Result<U, F> map<U>(U Function(S success) mapper) {
    if (isSuccess) {
      return Result.success(mapper(_success as S));
    } else {
      return Result.failure(_failure as F);
    }
  }
  
  /// Transforma el valor de fallo usando la función [mapper] proporcionada.
  ///
  /// Si este Result es un fallo, aplica [mapper] al valor de fallo y devuelve
  /// un nuevo Result.failure con el valor transformado.
  /// Si este Result es un éxito, devuelve un nuevo Result.success con el mismo
  /// valor exitoso original.
  ///
  /// El tipo de fallo cambia de [F] a [U], mientras que el tipo de éxito [S] se mantiene.
  Result<S, U> mapFailure<U>(U Function(F failure) mapper) {
    if (isFailure) {
      return Result.failure(mapper(_failure as F));
    } else {
      return Result.success(_success as S);
    }
  }
}
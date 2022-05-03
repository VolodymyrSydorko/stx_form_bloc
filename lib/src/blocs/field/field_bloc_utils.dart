part of 'field_bloc.dart';

class FieldBlocUtils {
  FieldBlocUtils._();

  static String generateName(String? name) {
    return name ?? Uuid().v1();
  }

  /// Returns the error of the [_initialValue].
  static String? getInitialStateError<Value>({
    required Value value,
    required List<Validator<Value>>? validators,
  }) {
    String? error;

    if (validators != null) {
      for (var validator in validators) {
        error = validator(value);
        if (error != null) return error;
      }
    }

    return error;
  }
}

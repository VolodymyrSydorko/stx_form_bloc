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

class ValueAndError<Value> {
  final Value value;
  final Object? error;

  ValueAndError(this.value, this.error);
}

class EquatableList<T> with ListMixin<T> {
  static final _equality = const ListEquality<dynamic>();

  final List<T> _internal;

  EquatableList._(this._internal);

  factory EquatableList(List<T> list) {
    return list is EquatableList<T> ? list : EquatableList._(list);
  }

  @override
  int get length => _internal.length;
  @override
  set length(int newLength) => _internal.length = newLength;

  @override
  T operator [](int index) => _internal[index];

  @override
  void operator []=(int index, T value) {
    _internal[index] = value;
  }

  @override
  int get hashCode => _equality.hash(this);

  @override
  bool operator ==(Object other) {
    if (other is! List<T>) return false;
    return _equality.equals(this, other);
  }
}

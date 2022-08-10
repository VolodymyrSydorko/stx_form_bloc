import 'package:stx_form_bloc/src/blocs/text_field/text_field_bloc.dart';

typedef Validator<Value> = String? Function(Value value);

enum ValidationType {
  onMounted,
  onChange,
  onBlur,
  onClear,
}

extension ValidationTypeX on List<ValidationType>? {
  bool get hasOnMounted => this?.contains(ValidationType.onMounted) == true;
  bool get hasOnChange => this?.contains(ValidationType.onChange) == true;
  bool get hasOnBlur => this?.contains(ValidationType.onBlur) == true;
  bool get hasOnClear => this?.contains(ValidationType.onClear) == true;
}

class FieldBlocValidatorsErrors {
  FieldBlocValidatorsErrors._();

  static const String required = 'Field is required';

  static const String email = 'Email is invalid';

  static const String passwordMin6Chars =
      'Password length must be at least 6 characters';

  static const String confirmPassword = 'Confirm Password - Validator Error';
}

class FieldBlocValidators {
  FieldBlocValidators._();

  static List<Validator<T>> getValidators<T>(
      List<Validator<T>>? validators, bool? required) {
    return [
      if (required == true) FieldBlocValidators.required,
      ...?validators,
    ];
  }

  /// Check if the [value] is is not null, not empty or false.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.required]
  /// if is not valid.
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return FieldBlocValidatorsErrors.required;
    }

    return null;
  }

  /// Check if the [string] is an email
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.email]
  /// if is not valid.
  static String? email(String? string) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (string == null || string.isEmpty || emailRegExp.hasMatch(string)) {
      return null;
    }

    return FieldBlocValidatorsErrors.email;
  }

  /// Check if the [string] has min 6 chars
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.passwordMin6Chars]
  /// if is not valid.
  static String? passwordMin6Chars(String? string) {
    if (string == null || string.isEmpty || string.runes.length >= 6) {
      return null;
    }

    return FieldBlocValidatorsErrors.passwordMin6Chars;
  }

  /// Check if the `value` of the current [TextFieldBloc] is equals
  /// to [passwordTextFieldBloc.value].
  ///
  /// Returns a [Validator] `String Function(String string)`.
  ///
  /// This validator check if the `string` is equal to the current
  /// value of the [TextFieldBloc]
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.email]
  /// if is not valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.passwordMin6Chars]
  /// if is not valid.
  static Validator<String?> confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == null ||
          confirmPassword.isEmpty ||
          confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return FieldBlocValidatorsErrors.confirmPassword;
    };
  }
}

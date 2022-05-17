part of 'text_field_bloc.dart';

class TextFieldBlocState extends FieldBlocState<String> {
  TextFieldBlocState({
    required String name,
    required String initialValue,
    required String value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<String>> validators,
    required List<ValidationType> rules,
    required String? error,
    required bool enabled,
    FormBloc? formBloc,
  }) : super(
          name: name,
          initialValue: initialValue,
          value: value,
          isValueChanged: isValueChanged,
          isDirty: isDirty,
          validators: validators,
          rules: rules,
          error: error,
          enabled: enabled,
          formBloc: formBloc,
        );

  int? get valueToInt => int.tryParse(value);

  double? get valueToDouble => double.tryParse(value);

  @override
  TextFieldBlocState copyWith({
    String? initialValue,
    String? value,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<String>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? formBloc = empty,
  }) {
    return TextFieldBlocState(
      name: name,
      initialValue: initialValue ?? this.initialValue,
      value: value ?? this.value,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: error == empty ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

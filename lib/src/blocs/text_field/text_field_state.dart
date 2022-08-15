part of 'text_field_bloc.dart';

class TextFieldBlocState extends FieldBlocState<String> {
  TextFieldBlocState({
    required super.name,
    required super.initialValue,
    required super.value,
    required super.isValueChanged,
    required super.isDirty,
    required super.validators,
    required super.rules,
    required super.error,
    required super.enabled,
    super.data,
    super.formBloc,
  });

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
    Object? data = empty,
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
      data: data == empty ? this.data : data,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

part of 'text_field_bloc.dart';

class TextFieldBlocState extends FieldBlocState<String> {
  TextFieldBlocState({
    required String name,
    required String initialValue,
    required String value,
    required String? error,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<String>> validators,
    FormBloc? formBloc,
  }) : super(
          name: name,
          initialValue: initialValue,
          value: value,
          error: error,
          isValueChanged: isValueChanged,
          isDirty: isDirty,
          validators: validators,
          formBloc: formBloc,
        );

  int? get valueToInt => int.tryParse(value);

  double? get valueToDouble => double.tryParse(value);

  @override
  TextFieldBlocState copyWith({
    String? initialValue,
    String? value,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<String>>? validators,
    Object? formBloc = empty,
  }) {
    return TextFieldBlocState(
      name: name,
      initialValue: initialValue ?? this.initialValue,
      value: value ?? this.value,
      error: error == empty ? this.error : error as String?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

part of 'number_field_bloc.dart';

class NumberFieldBlocState extends FieldBlocState<double?> {
  NumberFieldBlocState({
    required String name,
    required double? initialValue,
    required double? value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<double?>> validators,
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

  @override
  NumberFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<double?>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? formBloc = empty,
  }) {
    return NumberFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as double?,
      value: value == empty ? this.value : value as double?,
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

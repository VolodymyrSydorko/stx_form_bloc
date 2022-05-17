part of 'boolean_field_bloc.dart';

class BooleanFieldBlocState extends FieldBlocState<bool?> {
  BooleanFieldBlocState({
    required String name,
    required bool? initialValue,
    required bool? value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<bool?>> validators,
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
  BooleanFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<bool?>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? formBloc = empty,
  }) {
    return BooleanFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as bool?,
      value: value == empty ? this.value : value as bool?,
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

part of 'boolean_field_bloc.dart';

class BooleanFieldBlocState extends FieldBlocState<bool?> {
  BooleanFieldBlocState({
    required super.name,
    required super.initialValue,
    required super.value,
    required super.isValueChanged,
    required super.isDirty,
    required super.validators,
    required super.rules,
    required super.error,
    required super.enabled,
    required super.loading,
    super.extraData,
    super.formBloc,
  });

  @override
  BooleanFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<bool?>>? validators,
    Set<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    bool? loading,
    Object? extraData = empty,
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
      loading: loading ?? this.loading,
      extraData: extraData == empty ? this.extraData : extraData,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

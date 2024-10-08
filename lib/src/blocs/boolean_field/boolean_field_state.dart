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
    required super.readOnly,
    required super.loading,
    super.data,
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
    bool? readOnly,
    bool? loading,
    Object? data = empty,
    Object? extraData = empty,
    Object? formBloc = empty,
  }) {
    return BooleanFieldBlocState(
      name: name,
      initialValue:
          empty == initialValue ? this.initialValue : initialValue as bool?,
      value: empty == value ? this.value : value as bool?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: empty == error ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      loading: loading ?? this.loading,
      data: empty == data ? this.data : data,
      extraData: empty == extraData ? this.extraData : extraData,
      formBloc: empty == formBloc ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

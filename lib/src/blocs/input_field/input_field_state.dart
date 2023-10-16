part of 'input_field_bloc.dart';

class InputFieldBlocState<T> extends FieldBlocState<T> {
  InputFieldBlocState({
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
  InputFieldBlocState<T> copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<T>>? validators,
    Set<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    bool? readOnly,
    bool? loading,
    Object? data = empty,
    Object? extraData = empty,
    Object? formBloc = empty,
  }) {
    return InputFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as T,
      value: value == empty ? this.value : value as T,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: error == empty ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      loading: loading ?? this.loading,
      data: data == empty ? this.data : data,
      extraData: extraData == empty ? this.extraData : extraData,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

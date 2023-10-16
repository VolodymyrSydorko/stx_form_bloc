part of 'list_field_bloc.dart';

class ListFieldBlocState<T> extends FieldBlocState<List<T>> {
  ListFieldBlocState({
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
  ListFieldBlocState<T> copyWith({
    List<T>? initialValue,
    List<T>? value,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<List<T>>>? validators,
    Set<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    bool? readOnly,
    bool? loading,
    Object? data = empty,
    Object? extraData = empty,
    Object? formBloc = empty,
  }) {
    return ListFieldBlocState(
      name: name,
      initialValue: initialValue ?? this.initialValue,
      value: value ?? this.value,
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

part of 'list_field_bloc.dart';

class ListFieldBlocState<T> extends FieldBlocState<List<T>> {
  ListFieldBlocState({
    required String name,
    required List<T> initialValue,
    required List<T> value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<List<T>>> validators,
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
  ListFieldBlocState<T> copyWith({
    List<T>? initialValue,
    List<T>? value,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<List<T>>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
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
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

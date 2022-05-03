part of 'list_field_bloc.dart';

class ListFieldBlocState<T> extends FieldBlocState<List<T>> {
  ListFieldBlocState({
    required String name,
    required List<T> initialValue,
    required List<T> value,
    required String? error,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<List<T>>> validators,
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

  @override
  ListFieldBlocState<T> copyWith({
    List<T>? initialValue,
    List<T>? value,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<List<T>>>? validators,
    Object? formBloc = empty,
  }) {
    return ListFieldBlocState(
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

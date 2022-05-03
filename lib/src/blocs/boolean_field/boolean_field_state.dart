part of 'boolean_field_bloc.dart';

class BooleanFieldBlocState extends FieldBlocState<bool?> {
  BooleanFieldBlocState({
    required String name,
    required bool? initialValue,
    required bool? value,
    required String? error,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<bool?>> validators,
    FormBloc? formBloc,
  }) : super(
          name: name,
          initialValue: initialValue,
          value: value,
          error: error,
          isValueChanged: isValueChanged,
          isDirty: isDirty,
          formBloc: formBloc,
          validators: validators,
        );

  @override
  BooleanFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<bool?>>? validators,
    Object? formBloc = empty,
  }) {
    return BooleanFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as bool?,
      value: value == empty ? this.value : value as bool?,
      error: error == empty ? this.error : error as String?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }
}

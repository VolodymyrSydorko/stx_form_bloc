part of 'select_field_bloc.dart';

class SelectFieldBlocState<Value> extends FieldBlocState<Value?> {
  SelectFieldBlocState({
    required bool isValueChanged,
    required Value? initialValue,
    required Value? value,
    required String? error,
    required bool isDirty,
    required List<Validator<Value?>> validators,
    FormBloc? formBloc,
    required String name,
    required this.items,
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

  final List<Value> items;

  @override
  SelectFieldBlocState<Value> copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<Value?>>? validators,
    Object? formBloc = empty,
    List<Value>? items,
  }) {
    return SelectFieldBlocState<Value>(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as Value?,
      value: value == empty ? this.value : value as Value?,
      error: error == empty ? this.error : error as String?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [...super.props, items];
}

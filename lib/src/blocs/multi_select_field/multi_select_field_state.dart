part of 'multi_select_field_bloc.dart';

class MultiSelectFieldBlocState<Value> extends FieldBlocState<List<Value>> {
  final List<Value> items;

  MultiSelectFieldBlocState({
    required String name,
    required List<Value> initialValue,
    required List<Value> value,
    required String? error,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<List<Value>>> validators,
    FormBloc? formBloc,
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

  @override
  MultiSelectFieldBlocState<Value> copyWith({
    List<Value>? initialValue,
    List<Value>? value,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<List<Value>>>? validators,
    Object? formBloc = empty,
    List<Value>? items,
  }) {
    return MultiSelectFieldBlocState<Value>(
      name: name,
      initialValue: initialValue ?? this.initialValue,
      value: value ?? this.value,
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

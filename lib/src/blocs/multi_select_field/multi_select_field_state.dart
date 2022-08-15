part of 'multi_select_field_bloc.dart';

class MultiSelectFieldBlocState<Value> extends FieldBlocState<List<Value>> {
  final List<Value> items;

  MultiSelectFieldBlocState({
    required super.name,
    required super.initialValue,
    required super.value,
    required super.isValueChanged,
    required super.isDirty,
    required super.validators,
    required super.rules,
    required super.error,
    required super.enabled,
    super.data,
    super.formBloc,
    required this.items,
  });

  @override
  MultiSelectFieldBlocState<Value> copyWith({
    List<Value>? initialValue,
    List<Value>? value,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<List<Value>>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? data = empty,
    Object? formBloc = empty,
    List<Value>? items,
  }) {
    return MultiSelectFieldBlocState<Value>(
      name: name,
      initialValue: initialValue ?? this.initialValue,
      value: value ?? this.value,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: error == empty ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      data: data == empty ? this.data : data,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [...super.props, items];
}

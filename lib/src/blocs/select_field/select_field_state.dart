part of 'select_field_bloc.dart';

class SelectFieldBlocState<Value> extends FieldBlocState<Value?> {
  SelectFieldBlocState({
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

  final List<Value> items;

  @override
  SelectFieldBlocState<Value> copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<Value?>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? data = empty,
    Object? formBloc = empty,
    List<Value>? items,
  }) {
    return SelectFieldBlocState<Value>(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as Value?,
      value: value == empty ? this.value : value as Value?,
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

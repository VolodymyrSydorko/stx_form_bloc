part of 'multi_select_field_bloc.dart';

class MultiSelectFieldBlocState<Value> extends FieldBlocState<List<Value>> {
  final List<Value> items;

  MultiSelectFieldBlocState({
    required String name,
    required List<Value> initialValue,
    required List<Value> value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<List<Value>>> validators,
    required List<ValidationType> rules,
    required String? error,
    required bool enabled,
    FormBloc? formBloc,
    required this.items,
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
  MultiSelectFieldBlocState<Value> copyWith({
    List<Value>? initialValue,
    List<Value>? value,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<List<Value>>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
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
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [...super.props, items];
}

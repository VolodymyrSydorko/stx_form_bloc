part of 'select_field_bloc.dart';

class SelectFieldBlocState<Value> extends FieldBlocState<Value?> {
  SelectFieldBlocState({
    required String name,
    required Value? initialValue,
    required Value? value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<Value?>> validators,
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
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [...super.props, items];
}

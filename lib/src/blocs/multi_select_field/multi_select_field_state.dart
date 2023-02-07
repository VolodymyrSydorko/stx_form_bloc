part of 'multi_select_field_bloc.dart';

class MultiSelectFieldBlocState<Value> extends FieldBlocState<List<Value>> {
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
    super.extraData,
    super.formBloc,
    required this.options,
    required this.disabledOptions,
  });

  final List<Value> options;
  final List<Value> disabledOptions;

  @override
  MultiSelectFieldBlocState<Value> copyWith({
    List<Value>? initialValue,
    List<Value>? value,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<List<Value>>>? validators,
    Set<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? extraData = empty,
    Object? formBloc = empty,
    List<Value>? options,
    List<Value>? disabledOptions,
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
      extraData: extraData == empty ? this.extraData : extraData,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      options: options ?? this.options,
      disabledOptions: disabledOptions ?? this.disabledOptions,
    );
  }

  @override
  List<Object?> get props => [...super.props, options, disabledOptions];
}

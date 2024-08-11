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
    required super.readOnly,
    required super.loading,
    super.data,
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
    bool? readOnly,
    bool? loading,
    Object? data = empty,
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
      error: empty == error ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      loading: loading ?? this.loading,
      data: empty == data ? this.data : data,
      extraData: empty == extraData ? this.extraData : extraData,
      formBloc: empty == formBloc ? this.formBloc : formBloc as FormBloc?,
      options: options ?? this.options,
      disabledOptions: disabledOptions ?? this.disabledOptions,
    );
  }

  @override
  List<Object?> get props => [...super.props, options, disabledOptions];
}

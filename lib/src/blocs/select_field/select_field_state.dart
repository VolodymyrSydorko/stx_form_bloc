part of 'select_field_bloc.dart';

class SelectFieldBlocState<Value> extends InputFieldBlocState<Value?> {
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
  SelectFieldBlocState<Value> copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<Value?>>? validators,
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
      readOnly: readOnly ?? this.readOnly,
      loading: loading ?? this.loading,
      data: data == empty ? this.data : data,
      extraData: extraData == empty ? this.extraData : extraData,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      options: options ?? this.options,
      disabledOptions: disabledOptions ?? this.disabledOptions,
    );
  }

  @override
  List<Object?> get props => [...super.props, options, disabledOptions];
}

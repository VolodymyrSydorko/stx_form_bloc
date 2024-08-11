part of 'date_time_field_bloc.dart';

class DateTimeFieldBlocState extends FieldBlocState<DateTime?> {
  DateTimeFieldBlocState({
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
    required this.dateFormat,
    required this.firstDate,
    required this.lastDate,
  });

  final DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  DateTimeFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    Set<Validator<DateTime?>>? validators,
    Set<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    bool? readOnly,
    bool? loading,
    Object? data = empty,
    Object? extraData = empty,
    Object? formBloc = empty,
    Object? dateFormat = empty,
    Object? firstDate = empty,
    Object? lastDate = empty,
  }) {
    return DateTimeFieldBlocState(
      name: name,
      initialValue:
          empty == initialValue ? this.initialValue : initialValue as DateTime?,
      value: empty == value ? this.value : value as DateTime?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: empty == error ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      readOnly: readOnly ?? this.readOnly,
      loading: loading ?? this.loading,
      extraData: empty == extraData ? this.extraData : extraData,
      data: empty == data ? this.data : data,
      formBloc: empty == formBloc ? this.formBloc : formBloc as FormBloc?,
      dateFormat:
          empty == dateFormat ? this.dateFormat : dateFormat as DateFormat?,
      firstDate: empty == firstDate ? this.firstDate : firstDate as DateTime?,
      lastDate: empty == lastDate ? this.lastDate : lastDate as DateTime?,
    );
  }

  @override
  List<Object?> get props => [...super.props, firstDate, lastDate];

  @override
  String? toNullableString() {
    if (value == null) return null;

    return dateFormat != null ? dateFormat!.format(value!) : value!.toString();
  }

  @override
  String toString() {
    if (value == null) return '';

    return dateFormat != null ? dateFormat!.format(value!) : value!.toString();
  }
}

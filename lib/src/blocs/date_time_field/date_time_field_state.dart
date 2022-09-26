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
    super.data,
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
    Object? data = empty,
    Object? formBloc = empty,
    Object? dateFormat = empty,
    Object? firstDate = empty,
    Object? lastDate = empty,
  }) {
    return DateTimeFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as DateTime?,
      value: value == empty ? this.value : value as DateTime?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      rules: rules ?? this.rules,
      error: error == empty ? this.error : error as String?,
      enabled: enabled ?? this.enabled,
      data: data == empty ? this.data : data,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      dateFormat:
          dateFormat == empty ? this.dateFormat : dateFormat as DateFormat?,
      firstDate: firstDate == empty ? this.firstDate : firstDate as DateTime?,
      lastDate: lastDate == empty ? this.lastDate : lastDate as DateTime?,
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

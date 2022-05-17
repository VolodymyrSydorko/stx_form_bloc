part of 'datetime_field_bloc.dart';

class DateTimeFieldBlocState extends FieldBlocState<DateTime?> {
  DateTimeFieldBlocState({
    required String name,
    required DateTime? initialValue,
    required DateTime? value,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<DateTime?>> validators,
    required List<ValidationType> rules,
    required String? error,
    required bool enabled,
    required this.firstDate,
    required this.lastDate,
    FormBloc? formBloc,
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

  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  DateTimeFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<DateTime?>>? validators,
    List<ValidationType>? rules,
    Object? error = empty,
    bool? enabled,
    Object? formBloc = empty,
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
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      firstDate: firstDate == empty ? this.firstDate : firstDate as DateTime?,
      lastDate: lastDate == empty ? this.lastDate : lastDate as DateTime?,
    );
  }

  @override
  List<Object?> get props => [...super.props, firstDate, lastDate];
}

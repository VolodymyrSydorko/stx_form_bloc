part of 'datetime_field_bloc.dart';

class DateTimeFieldBlocState extends FieldBlocState<DateTime?> {
  DateTimeFieldBlocState({
    required String name,
    required DateTime? initialValue,
    required DateTime? value,
    required String? error,
    required bool isValueChanged,
    required bool isDirty,
    required List<Validator<DateTime?>> validators,
    required this.firstDate,
    required this.lastDate,
    FormBloc? formBloc,
  }) : super(
          name: name,
          initialValue: initialValue,
          value: value,
          error: error,
          isValueChanged: isValueChanged,
          isDirty: isDirty,
          formBloc: formBloc,
          validators: validators,
        );

  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  DateTimeFieldBlocState copyWith({
    Object? initialValue = empty,
    Object? value = empty,
    Object? error = empty,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<DateTime?>>? validators,
    Object? firstDate = empty,
    Object? lastDate = empty,
    Object? formBloc = empty,
  }) {
    return DateTimeFieldBlocState(
      name: name,
      initialValue:
          initialValue == empty ? this.initialValue : initialValue as DateTime?,
      value: value == empty ? this.value : value as DateTime?,
      error: error == empty ? this.error : error as String?,
      isValueChanged: isValueChanged ?? this.isValueChanged,
      isDirty: isDirty ?? this.isDirty,
      validators: validators ?? this.validators,
      firstDate: firstDate == empty ? this.firstDate : firstDate as DateTime?,
      lastDate: lastDate == empty ? this.lastDate : lastDate as DateTime?,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
    );
  }

  @override
  List<Object?> get props => [...super.props, firstDate, lastDate];
}

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'date_time_field_state.dart';

class DateTimeFieldBloc
    extends SingleFieldBloc<DateTime?, DateTimeFieldBlocState> {
  DateTimeFieldBloc({
    String? name,
    DateTime? initialValue,
    bool enabled = true,
    bool readOnly = false,
    bool loading = false,
    bool? required,
    Set<Validator<DateTime?>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
    dynamic extraData,
    DateFormat? dateFormat,
    DateTime? firstDate,
    DateTime? lastDate,
  }) : super(
          initialState: DateTimeFieldBlocState(
            name: FieldBlocUtils.generateName(name),
            initialValue: initialValue,
            value: initialValue,
            isValueChanged: false,
            isDirty: rules.hasOnMounted,
            validators: FieldBlocValidators.getValidators(
              customValidators,
              required,
            ),
            rules: rules,
            error: FieldBlocUtils.getInitialStateError(
              value: initialValue,
              validators: FieldBlocValidators.getValidators(
                customValidators,
                required,
              ),
            ),
            enabled: enabled,
            readOnly: readOnly,
            loading: loading,
            data: data,
            extraData: extraData,
            dateFormat: dateFormat,
            firstDate: firstDate,
            lastDate: lastDate,
          ),
          defaultValue: null,
        );

  StreamSubscription? firstDateSubscription;
  StreamSubscription? lastDateSubscription;

  changeDateFormat(DateFormat newDateFormat) {
    emit(state.copyWith(dateFormat: newDateFormat));
  }

  changeFirstDate(DateTime? firstDate, {bool force = false}) {
    if (!force && (disabled || readOnly)) return;

    final error = getError(value);

    emit(state.copyWith(
      firstDate: firstDate,
      error: error,
      isDirty: rules.hasOnChange,
    ));

    emit(state.copyWith(firstDate: firstDate));
  }

  changeLastDate(DateTime? lastDate, {bool force = false}) {
    if (!force && (disabled || readOnly)) return;

    final error = getError(value);

    emit(state.copyWith(
      lastDate: lastDate,
      error: error,
      isDirty: rules.hasOnChange,
    ));
  }

  setFirstDateBloc(DateTimeFieldBloc? firstDateBloc, {bool force = false}) {
    firstDateSubscription?.cancel();

    firstDateSubscription = firstDateBloc?.valueStream.listen((firstDate) {
      if (state.firstDate != firstDate) {
        changeFirstDate(firstDate, force: force);
      }
    });
  }

  setLastDateBloc(DateTimeFieldBloc? lastDateBloc, {bool force = false}) {
    lastDateSubscription?.cancel();

    lastDateSubscription = lastDateBloc?.valueStream.listen((lastDate) {
      if (state.lastDate != lastDate) {
        changeLastDate(lastDate, force: force);
      }
    });
  }

  @override
  Future<void> close() {
    firstDateSubscription?.cancel();
    lastDateSubscription?.cancel();

    return super.close();
  }
}

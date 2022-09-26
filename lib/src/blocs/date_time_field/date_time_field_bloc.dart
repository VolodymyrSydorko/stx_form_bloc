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
    bool? required,
    Set<Validator<DateTime?>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
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
            data: data,
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

  setFirstDateBloc(DateTimeFieldBloc? firstDateBloc) {
    firstDateSubscription?.cancel();

    firstDateSubscription = firstDateBloc?.stream.listen((state) {
      if (this.state.firstDate != state.value) {
        emit(this.state.copyWith(firstDate: state.value));
      }
    });
  }

  setLastDateBloc(DateTimeFieldBloc? lastDateBloc) {
    lastDateSubscription?.cancel();

    lastDateSubscription = lastDateBloc?.stream.listen((state) {
      if (this.state.lastDate != state.value) {
        emit(this.state.copyWith(lastDate: state.value));
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

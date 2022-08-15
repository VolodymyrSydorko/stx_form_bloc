import 'dart:async';

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
    List<Validator<DateTime?>>? customValidators,
    List<ValidationType> rules = const [],
    dynamic data,
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
            firstDate: firstDate,
            lastDate: lastDate,
          ),
          defaultValue: null,
        );

  StreamSubscription? firstDateSubscription;
  StreamSubscription? lastDateSubscription;

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
  Future<void> close() async {
    firstDateSubscription?.cancel();
    lastDateSubscription?.cancel();

    await super.close();
  }
}

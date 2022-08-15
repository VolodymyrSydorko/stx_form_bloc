import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'number_field_state.dart';

class NumberFieldBloc extends SingleFieldBloc<int?, NumberFieldBlocState> {
  NumberFieldBloc({
    String? name,
    int? initialValue,
    bool enabled = true,
    bool? required,
    List<Validator<int?>>? customValidators,
    List<ValidationType> rules = const [],
    dynamic data,
  })  : assert(required == null || customValidators == null),
        super(
          initialState: NumberFieldBlocState(
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
          ),
          defaultValue: null,
        );
}

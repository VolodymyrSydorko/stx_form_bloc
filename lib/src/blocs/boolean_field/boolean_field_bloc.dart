import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'boolean_field_state.dart';

class BooleanFieldBloc extends SingleFieldBloc<bool?, BooleanFieldBlocState> {
  BooleanFieldBloc({
    String? name,
    bool? initialValue,
    bool enabled = true,
    bool? required,
    List<Validator<bool?>>? customValidators,
    List<ValidationType> rules = const [],
  })  : assert(required == null || customValidators == null),
        super(
          initialState: BooleanFieldBlocState(
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
          ),
          defaultValue: null,
        );
}

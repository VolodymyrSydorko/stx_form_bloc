import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'boolean_field_state.dart';

class BooleanFieldBloc extends SingleFieldBloc<bool?, BooleanFieldBlocState> {
  BooleanFieldBloc({
    String? name,
    bool initialValue = false,
    List<Validator<bool?>> validators = const [],
    List<ValidationType>? rules,
  }) : super(
          initialState: BooleanFieldBlocState(
            name: FieldBlocUtils.generateName(name),
            initialValue: initialValue,
            value: initialValue,
            error: FieldBlocUtils.getInitialStateError(
              value: initialValue,
              validators: validators,
            ),
            isValueChanged: false,
            isDirty: rules.hasOnMounted,
            validators: validators,
          ),
          defaultValue: null,
          rules: rules,
        );
}

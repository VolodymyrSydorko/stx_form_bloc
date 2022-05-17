import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'text_field_state.dart';

class TextFieldBloc extends SingleFieldBloc<String, TextFieldBlocState> {
  TextFieldBloc({
    String? name,
    String initialValue = '',
    bool enabled = true,
    bool? required,
    List<Validator<String>>? customValidators,
    List<ValidationType> rules = const [],
  }) : super(
          initialState: TextFieldBlocState(
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
          defaultValue: '',
        );

  int? get valueToInt => state.valueToInt;

  double? get valueToDouble => state.valueToDouble;
}

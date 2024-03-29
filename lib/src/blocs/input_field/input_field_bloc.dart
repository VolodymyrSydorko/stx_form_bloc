import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'input_field_state.dart';

class InputFieldBloc<T> extends SingleFieldBloc<T, InputFieldBlocState<T>> {
  InputFieldBloc({
    String? name,
    required T initialValue,
    bool enabled = true,
    bool readOnly = false,
    bool loading = false,
    bool? required,
    Set<Validator<T>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
    dynamic extraData,
    required super.defaultValue,
  }) : super(
          initialState: InputFieldBlocState<T>(
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
          ),
        );
}

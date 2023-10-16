import 'package:stx_form_bloc/src/blocs/input_field/input_field_bloc.dart';

part 'number_field_state.dart';

class NumberFieldBloc extends InputFieldBloc<int?> {
  NumberFieldBloc({
    super.name,
    super.initialValue,
    super.enabled,
    super.readOnly,
    super.required,
    super.customValidators,
    super.rules,
    super.loading,
    super.data,
    super.extraData,
  }) : super(defaultValue: null);
}

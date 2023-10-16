import 'package:stx_form_bloc/src/blocs/input_field/input_field_bloc.dart';

part 'text_field_state.dart';

class TextFieldBloc extends InputFieldBloc<String?> {
  TextFieldBloc({
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

  int? get valueToInt => state.valueToInt;

  double? get valueToDouble => state.valueToDouble;
}

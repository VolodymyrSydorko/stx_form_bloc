import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'text_field_state.dart';

class TextFieldBloc extends SingleFieldBloc<String, TextFieldBlocState> {
  TextFieldBloc({
    String? name,
    String initialValue = '',
    List<Validator<String>> validators = const [],
    List<ValidationType>? rules,
  }) : super(
          initialState: TextFieldBlocState(
              name: FieldBlocUtils.generateName(name),
              initialValue: initialValue,
              value: initialValue,
              error: FieldBlocUtils.getInitialStateError(
                value: initialValue,
                validators: validators,
              ),
              isValueChanged: false,
              isDirty: rules.hasOnMounted,
              validators: validators),
          defaultValue: '',
          rules: rules,
        );

  int? get valueToInt => state.valueToInt;

  double? get valueToDouble => state.valueToDouble;
}

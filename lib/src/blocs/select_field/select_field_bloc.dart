import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/extension.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'select_field_state.dart';

class SelectFieldBloc<Value>
    extends SingleFieldBloc<Value?, SelectFieldBlocState<Value>> {
  SelectFieldBloc({
    String? name,
    Value? initialValue,
    bool enabled = true,
    bool? required,
    Set<Validator<Value?>>? customValidators,
    Set<ValidationType> rules = const {},
    List<Value> options = const [],
    dynamic data,
  }) : super(
          initialState: SelectFieldBlocState(
            name: FieldBlocUtils.generateName(name),
            initialValue: options.contains(initialValue) ? initialValue : null,
            value: options.contains(initialValue) ? initialValue : null,
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
            options: options,
          ),
          defaultValue: null,
        );

  List<Value> get options => state.options;

  void changeOptions(List<Value> options) {
    emit(state.copyWith(
      options: options,
    ));
  }

  void addOption(Value newOption) => addOptions([newOption]);
  void addOptions(List<Value> newOptions) {
    final updatedOptions = [...state.options, ...newOptions];

    changeOptions(updatedOptions);
  }

  void removeOption(Value option) => removeOptions([option]);
  void removeOptions(List<Value> options) {
    if (state.options.isNotEmpty) {
      final updatedOptions = [...state.options]..removeAll(options);

      changeOptions(updatedOptions);
    }
  }

  void clearOptions() => changeOptions([]);

  @override
  void emit(SelectFieldBlocState<Value> state) {
    if (initialValue != state.initialValue ||
        value != state.value ||
        options != state.options) {
      state = state.copyWith(
        initialValue: state.options.contains(state.initialValue)
            ? state.initialValue
            : null,
        value: state.options.contains(state.value) ? state.value : null,
      );
    }

    super.emit(state);
  }
}

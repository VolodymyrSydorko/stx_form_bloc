import 'package:darq/darq.dart';
import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/extension.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'multi_select_field_state.dart';

class MultiSelectFieldBloc<Value>
    extends SingleFieldBloc<List<Value>, MultiSelectFieldBlocState<Value>> {
  MultiSelectFieldBloc({
    String? name,
    List<Value> initialValue = const [],
    bool enabled = true,
    bool? required,
    Set<Validator<List<Value>>>? customValidators,
    Set<ValidationType> rules = const {},
    List<Value> options = const [],
    dynamic data,
    this.forceValueToSet = false,
  }) : super(
          initialState: MultiSelectFieldBlocState(
            name: FieldBlocUtils.generateName(name),
            initialValue: forceValueToSet
                ? initialValue
                : initialValue.intersect(options).toList(),
            value: forceValueToSet
                ? initialValue
                : initialValue.intersect(options).toList(),
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
          defaultValue: const [],
        );

  final bool forceValueToSet;

  List<Value> get options => state.options;

  void changeOptions(List<Value> options) {
    emit(state.copyWith(options: options));
  }

  void addItem(Value newItem) => addOptions([newItem]);
  void addOptions(List<Value> newOptions) {
    final updatedOptions = [...state.options, ...newOptions];

    changeOptions(updatedOptions);
  }

  void removeItem(Value item) => removeOptions([item]);
  void removeOptions(List<Value> options) {
    if (state.options.isNotEmpty) {
      final updatedOptions = [...state.options]..removeAll(options);

      changeOptions(updatedOptions);
    }
  }

  void clearOptions() => changeOptions([]);

  void selectValue(Value valueToSelect) =>
      changeValue([...value, valueToSelect]);

  void deselectValue(Value valueToDeselect) =>
      changeValue([...value]..remove(valueToDeselect));

  @override
  void emit(MultiSelectFieldBlocState<Value> state) {
    if (!forceValueToSet &&
        (initialValue != state.initialValue ||
            value != state.value ||
            options != state.options)) {
      state = state.copyWith(
          initialValue: state.initialValue.intersect(state.options).toList(),
          value: state.value.intersect(state.options).toList());
    }

    super.emit(state);
  }
}

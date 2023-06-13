import 'package:darq/darq.dart';
import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/blocs/input_field/input_field_bloc.dart';
import 'package:stx_form_bloc/src/extension.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'select_field_state.dart';

class SelectFieldBloc<Value>
    extends SingleFieldBloc<Value?, SelectFieldBlocState<Value>> {
  SelectFieldBloc({
    String? name,
    Value? initialValue,
    bool enabled = true,
    bool loading = false,
    bool? required,
    Set<Validator<Value?>>? customValidators,
    Set<ValidationType> rules = const {},
    List<Value> options = const [],
    List<Value> disabledOptions = const [],
    dynamic extraData,
    this.forceValueToSet = false,
  }) : super(
          initialState: SelectFieldBlocState(
            name: FieldBlocUtils.generateName(name),
            initialValue: forceValueToSet ||
                    options.except(disabledOptions).contains(initialValue)
                ? initialValue
                : null,
            value: forceValueToSet ||
                    options.except(disabledOptions).contains(initialValue)
                ? initialValue
                : null,
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
            loading: loading,
            extraData: extraData,
            options: options,
            disabledOptions: disabledOptions,
          ),
          defaultValue: null,
        );

  final bool forceValueToSet;

  List<Value> get options => state.options;
  List<Value> get disabledOptions => state.disabledOptions;

  Iterable<Value> get availableOptions => options.except(disabledOptions);

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

  void changeDisabledOptions(List<Value> disabledOptions) {
    emit(state.copyWith(disabledOptions: disabledOptions));
  }

  void clearDisabledOptions() => changeDisabledOptions([]);

  @override
  void emit(SelectFieldBlocState<Value> state) {
    if (!forceValueToSet &&
        (initialValue != state.initialValue ||
            value != state.value ||
            options != state.options)) {
      final availableOptions = state.options.except(state.disabledOptions);

      state = state.copyWith(
        initialValue: availableOptions.contains(state.initialValue)
            ? state.initialValue
            : null,
        value: availableOptions.contains(state.value) ? state.value : null,
      );
    }

    super.emit(state);
  }
}

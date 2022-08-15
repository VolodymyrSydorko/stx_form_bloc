import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'multi_select_field_state.dart';

class MultiSelectFieldBloc<Value>
    extends SingleFieldBloc<List<Value>, MultiSelectFieldBlocState<Value>> {
  MultiSelectFieldBloc({
    String? name,
    List<Value> initialValue = const [],
    bool enabled = true,
    bool? required,
    List<Validator<List<Value>>>? customValidators,
    List<ValidationType> rules = const [],
    List<Value> items = const [],
    dynamic data,
  }) : super(
          initialState: MultiSelectFieldBlocState(
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
            data: data,
            items: items,
          ),
          defaultValue: const [],
        );

  void addItem(Value item) {
    emit(state.copyWith(items: [...state.items, item]));
  }

  void changeItems(List<Value> items) {
    emit(state.copyWith(
      items: items,
      value: items.contains(value) ? value : null,
    ));
  }

  void removeItem(Value item) {
    if (state.items.isNotEmpty) {
      final items = [...state.items]..remove(item);
      emit(state.copyWith(
        items: items,
        value: items.contains(value) ? value : null,
      ));
    }
  }

  void selectValue(Value valueToSelect) =>
      changeValue([...value, valueToSelect]);

  void deselectValue(Value valueToDeselect) =>
      changeValue([...value]..remove(valueToDeselect));
}

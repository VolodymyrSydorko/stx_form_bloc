import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'multi_select_field_state.dart';

class MultiSelectFieldBloc<Value>
    extends SingleFieldBloc<List<Value>, MultiSelectFieldBlocState<Value>> {
  MultiSelectFieldBloc({
    String? name,
    List<Value> initialValue = const [],
    List<Validator<List<Value>>> validators = const [],
    List<ValidationType>? rules,
    List<Value> items = const [],
  }) : super(
          initialState: MultiSelectFieldBlocState(
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
            items: items,
          ),
          defaultValue: const [],
          rules: rules,
        );

  void updateItems(List<Value> items) {
    emit(state.copyWith(
      items: items,
      value: items.contains(value) ? value : null,
    ));
  }

  void addItem(Value item) {
    emit(state.copyWith(items: [...state.items, item]));
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

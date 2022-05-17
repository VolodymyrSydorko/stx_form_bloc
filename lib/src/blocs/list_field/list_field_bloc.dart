import 'dart:collection';

import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'list_field_state.dart';

class ListFieldBloc<T> extends SingleFieldBloc<List<T>, ListFieldBlocState<T>>
    with IterableMixin<T> {
  ListFieldBloc({
    String? name,
    List<T> initialValue = const [],
    bool enabled = true,
    bool? required,
    List<Validator<List<T>>>? customValidators,
    List<ValidationType> rules = const [],
  }) : super(
          initialState: ListFieldBlocState(
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
          defaultValue: [],
        );

  void addItem(T newValue) {
    changeValue([...state.value, newValue]);
  }

  void addItems(List<T> newValues) {
    changeValue([...state.value, ...newValues]);
  }

  void insertItem(int index, T newValue) {
    changeValue([...state.value]..insert(index, newValue));
  }

  void insertItems(int index, List<T> newValues) {
    changeValue([...state.value]..insertAll(index, newValues));
  }

  void removeAt(int index) {
    changeValue([...state.value]..removeAt(index));
  }

  void removeItem(T value) {
    changeValue([...state.value]..remove(value));
  }

  void replaceAt(int index, T newValue) {
    changeValue([...state.value]..[index] = newValue);
  }

  void replaceWhere(bool Function(T) predicate, T newValue) {
    changeValue(
      state.value.map((value) => predicate(value) ? newValue : value).toList(),
    );
  }

  T operator [](int i) => state.value[i]; // get
  void operator []=(int i, T value) => state.value[i] = value;

  @override
  Iterator<T> get iterator => state.value.iterator;
}

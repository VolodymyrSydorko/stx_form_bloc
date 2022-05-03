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
    List<Validator<List<T>>> validators = const [],
    List<ValidationType>? rules,
  }) : super(
          initialState: ListFieldBlocState(
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
          ),
          defaultValue: [],
          rules: rules,
        );

  void addItem(T newValue) {
    changeValue([...state.value, newValue]);
  }

  void insert(int index, T newValue) {
    changeValue([...state.value]..insert(index, newValue));
  }

  void addItems(List<T> newValues) {
    changeValue([...state.value, ...newValues]);
  }

  void insertItems(int index, List<T> newValues) {
    changeValue([...state.value]..insertAll(index, newValues));
  }

  void removeItem(T value) {
    changeValue([...state.value]..remove(value));
  }

  void removeAt(int index) {
    changeValue([...state.value]..removeAt(index));
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

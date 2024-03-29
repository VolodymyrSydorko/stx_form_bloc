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
    bool readOnly = false,
    bool loading = false,
    bool? required,
    Set<Validator<List<T>>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
    dynamic extraData,
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
            readOnly: readOnly,
            loading: loading,
            data: data,
            extraData: extraData,
          ),
          defaultValue: [],
        );

  void add(T newValue) {
    value = [...value, newValue];
  }

  void addAll(List<T> newValues) {
    value = [...value, ...newValues];
  }

  void insert(int index, T newValue) {
    value = [...value]..insert(index, newValue);
  }

  void insertAll(int index, List<T> newValues) {
    value = [...value]..insertAll(index, newValues);
  }

  void removeAt(int index) {
    value = [...value]..removeAt(index);
  }

  void remove(T item) {
    value = [...value]..remove(item);
  }

  void removeWhere(bool Function(T element) test) {
    value = [...value]..removeWhere(test);
  }

  void replaceAt(int index, T newValue) {
    value = [...value]..[index] = newValue;
  }

  void replaceAllWhere(
      bool Function(T) predicate, T Function(T oldValue) newValue) {
    value = value
        .map((value) => predicate(value) ? newValue(value) : value)
        .toList();
  }

  void replaceWhere(
      bool Function(T) predicate, T Function(T oldValue) newValue) {
    final index = value.indexWhere(predicate);

    if (index >= 0) {
      this[index] = newValue(value[index]);
    }
  }

  T operator [](int i) => value[i];
  void operator []=(int i, T item) => value = [...value]..[i] = item;

  @override
  Iterator<T> get iterator => value.iterator;
}

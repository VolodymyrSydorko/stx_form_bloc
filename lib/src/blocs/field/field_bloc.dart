import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/extension.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

part 'field_bloc_utils.dart';
part 'field_state.dart';

mixin FieldBloc<State extends FieldBlocStateBase> on BlocBase<State> {
  String get name => state.name;

  bool validate();

  void reset();

  void clear();

  void updateFormBloc(FormBloc formBloc);

  void removeFormBloc(FormBloc formBloc);
}

abstract class SingleFieldBloc<Value, State extends FieldBlocState<Value>>
    extends Cubit<State> with FieldBloc {
  SingleFieldBloc({
    required State initialState,
    required this.defaultValue,
    required List<ValidationType>? rules,
  })  : _rules = rules ?? [],
        super(initialState) {
    // _streamController.add(initialState.value);
    // stream.listen((state) async {
    //   if (await valueChanged.last != state.value) {
    //     _streamController.add(state.value);
    //   }
    // });
  }

  final Value defaultValue;

  final List<ValidationType> _rules;

  Value get value => state.value;

  List<Validator<Value>> get validators => state.validators;

  bool get isRequired => validators.contains(FieldBlocValidators.required);

  bool get isValueChanged => state.isValueChanged;

  bool get isInitial => state.isInitial;

  bool get isValid => state.isValid;

  String? get error => state.error;

  String? get displayError => state.displayError;

  final _streamController = StreamController<Value>();
  Stream<Value> get valueChanged => _streamController.stream;

  @protected
  String? getError(Value value) {
    // if (this.value == value && this.validators == ) {
    //   return this.error;
    // }

    String? error;

    for (var validator in validators) {
      error = validator(value);
      if (error != null) return error;
    }

    return error;
  }

  void _validate({bool? shouldDirty}) {
    final error = getError(state.value);

    emit(state.copyWith(
      error: error,
      isDirty: shouldDirty,
    ) as State);
  }

  @override
  bool validate() {
    _validate(shouldDirty: true);

    return isValid;
  }

  void updateInitial(Value value) {
    final error = getError(state.value);

    emit(state.copyWith(
      initialValue: value,
      value: value,
      isValueChanged: false,
      error: error,
      isDirty: _rules.hasOnMounted,
    ) as State);
  }

  void changeValue(Value value) {
    final error = getError(value);

    emit(state.copyWith(
      value: value,
      error: error,
      isValueChanged: true,
      isDirty: _rules.hasOnChange,
    ) as State);
  }

  @override
  void clear() {
    final error = getError(defaultValue);

    emit(state.copyWith(
      value: defaultValue,
      error: error,
      isValueChanged: true,
      isDirty: _rules.hasOnChange || _rules.hasOnClear,
    ) as State);
  }

  @override
  void reset() {
    final value = state.initialValue;
    final error = getError(value);

    emit(state.copyWith(
      value: value,
      isValueChanged: false,
      error: error,
      isDirty: _rules.hasOnMounted || state.isDirty,
    ) as State);
  }

  void focusChanged() {
    emit(state.copyWith(
      isDirty: _rules.hasOnBlur || state.isDirty,
    ) as State);
  }

  void addValidators(
    List<Validator<Value>> validators, {
    bool forceValidation = false,
  }) {
    final updatedValidators = [...this.validators, ...validators];

    emit(state.copyWith(validators: updatedValidators) as State);

    _validate(shouldDirty: forceValidation);
  }

  void updateValidators(
    List<Validator<Value>> validators, {
    bool? isDirty,
  }) {
    emit(state.copyWith(validators: validators) as State);

    _validate(shouldDirty: isDirty);
  }

  void removeValidators(
    List<Validator<Value>> validators, {
    bool forceValidation = false,
  }) {
    final updatedValidators = [...this.validators]..removeAll(validators);

    emit(state.copyWith(validators: updatedValidators) as State);

    _validate(shouldDirty: forceValidation);
  }

  /// It is useful when you want to add errors that
  /// you have obtained when submitting the `FormBloc`.
  void addFieldError(String error, {bool? isDirty}) {
    emit(state.copyWith(
      error: error,
      isDirty: isDirty,
    ) as State);
  }

  @override
  void updateFormBloc(FormBloc formBloc) {
    emit(state.copyWith(
      formBloc: formBloc,
    ) as State);
  }

  @override
  void removeFormBloc(FormBloc formBloc) {
    if (state.formBloc == formBloc) {
      emit(state.copyWith(
        formBloc: null,
      ) as State);
    }
  }

  @override
  String toString() {
    return '$runtimeType';
  }
}

class MultiFieldBloc<TState extends MultiFieldBlocState> extends Cubit<TState>
    with FieldBloc<TState> {
  late final StreamSubscription _onValidationStatus;

  MultiFieldBloc(TState initialState) : super(initialState) {
    _onValidationStatus = stream.switchMap((state) {
      return MultiFieldBloc.onValidationStatus(state.flatFieldBlocs);
    }).listen((isValid) {
      emit(state.copyWith(
        isValid: isValid,
        hasDisplayError: deepHasDisplayError(flatFieldBlocs),
      ) as TState);
    });
  }

  Iterable<FieldBloc> get flatFieldBlocs => state.flatFieldBlocs;

  bool get isValuesChanged => FormBlocUtils.isValuesChanged(flatFieldBlocs);

  bool get isInitial => FormBlocUtils.hasInitialValues(flatFieldBlocs);

  bool get hasDisplayError => state.hasDisplayError;

  bool get isValid => state.isValid;

  @override
  void reset() {
    for (var f in flatFieldBlocs) {
      f.reset();
    }
  }

  @override
  void clear() {
    for (var f in flatFieldBlocs) {
      f.clear();
    }
  }

  @override
  bool validate() {
    final isValid = validateAll(state.flatFieldBlocs);

    emit(state.copyWith(
      hasDisplayError: deepHasDisplayError(flatFieldBlocs),
    ) as TState);

    return isValid;
  }

  @override
  void updateFormBloc(FormBloc formBloc) {
    emit(state.copyWith(
      formBloc: formBloc,
    ) as TState);

    FormBlocUtils.updateFormBloc(
      fieldBlocs: state.flatFieldBlocs,
      formBloc: formBloc,
    );
  }

  @override
  void removeFormBloc(FormBloc formBloc) {
    if (state.formBloc == formBloc) {
      emit(state.copyWith(
        formBloc: null,
      ) as TState);

      FormBlocUtils.removeFormBloc(
        fieldBlocs: state.flatFieldBlocs,
        formBloc: formBloc,
      );
    }
  }

  @override
  Future<void> close() {
    _onValidationStatus.cancel();
    for (final fieldBloc in state.flatFieldBlocs) {
      fieldBloc.close();
    }
    return super.close();
  }

  static Stream<bool> onValidationStatus(
    Iterable<FieldBloc> fieldBlocs,
  ) {
    return Rx.combineLatestList(fieldBlocs.map((fieldBloc) {
      return Rx.merge([Stream.value(fieldBloc.state), fieldBloc.stream]);
    })).map((fieldStates) {
      return fieldStates.every((fieldState) => fieldState.isValid);
    }).distinct();
  }

  static bool validateAll(Iterable<FieldBloc> fieldBlocs) {
    for (var field in fieldBlocs) {
      field.validate();
    }

    return fieldBlocs.every((field) => field.state.isValid);
  }

  static bool deepContains(Iterable<FieldBloc> fieldBlocs, FieldBloc target) {
    if (fieldBlocs.isEmpty) return false;

    for (final fieldBloc in fieldBlocs) {
      if (fieldBloc is MultiFieldBloc) {
        final contains =
            MultiFieldBloc.deepContains(fieldBloc.state.flatFieldBlocs, target);
        if (contains) {
          return true;
        }
      } else if (fieldBloc.state.name == target.state.name) {
        return true;
      }
    }
    return false;
  }

  static bool deepHasDisplayError(Iterable<FieldBloc> fieldBlocs) {
    if (fieldBlocs.isEmpty) return false;

    for (final fieldBloc in fieldBlocs) {
      if (fieldBloc is MultiFieldBloc) {
        final contains =
            MultiFieldBloc.deepHasDisplayError(fieldBloc.state.flatFieldBlocs);
        if (contains) {
          return true;
        }
      } else if (fieldBloc is SingleFieldBloc) {
        if (fieldBloc.state.displayError != null) {
          return true;
        }
      }
    }
    return false;
  }
}

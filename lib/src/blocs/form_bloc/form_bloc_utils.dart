part of 'form_bloc.dart';

class _Empty {
  const _Empty();

  @override
  bool operator ==(Object other) => other is _Empty;

  @override
  int get hashCode => 0;

  @override
  String toString() => '_Empty';
}

const empty = _Empty();

class FormBlocUtils {
  FormBlocUtils._();

  static void updateFormBloc({
    required Iterable<FieldBloc> fieldBlocs,
    required FormBloc? formBloc,
  }) {
    if (formBloc == null) return;

    for (final fieldBloc in fieldBlocs) {
      fieldBloc.updateFormBloc(formBloc);
    }
  }

  static void removeFormBloc({
    required Iterable<FieldBloc> fieldBlocs,
    required FormBloc? formBloc,
  }) {
    if (formBloc == null) return;

    for (final fieldBloc in fieldBlocs) {
      fieldBloc.removeFormBloc(formBloc);
    }
  }

  /// See [FormBloc.isValuesChanged]
  static bool isValuesChanged(
    Iterable<FieldBloc> fieldBlocs, {
    bool fallback = false,
  }) {
    return fieldBlocs.any((fb) {
      if (fb is SingleFieldBloc) {
        return fb.isValueChanged;
      } else if (fb is MultiFieldBloc) {
        return fb.isValuesChanged;
      }
      return fallback;
    });
  }

  /// See [FormBloc.hasInitialValues]
  static bool hasInitialValues(
    Iterable<FieldBloc> fieldBlocs, {
    bool fallback = true,
  }) {
    return fieldBlocs.every((fb) {
      if (fb is SingleFieldBloc) {
        return fb.isInitial;
      } else if (fb is MultiFieldBloc) {
        return fb.isInitial;
      }
      return fallback;
    });
  }

  static bool isValid(Iterable<FieldBloc> fieldBlocs) =>
      fieldBlocs.every((field) => field.state.isValid);
}

part of 'field_bloc.dart';

mixin FieldBlocStateBase {
  String get name;

  bool get isValid;

  bool get isNotValid => !isValid;

  FormBloc? get formBloc;

  bool get hasFormBloc => formBloc != null;
}

abstract class FieldBlocState<Value> extends Equatable with FieldBlocStateBase {
  FieldBlocState({
    required this.name,
    required this.initialValue,
    required this.value,
    required this.isValueChanged,
    required this.isDirty,
    required this.validators,
    required this.rules,
    required this.error,
    required this.enabled,
    required this.formBloc,
  });

  @override
  final String name;

  final Value initialValue;

  final Value value;

  final bool isValueChanged;

  final bool isDirty;

  final List<Validator<Value>> validators;

  final List<ValidationType> rules;

  final String? error;

  final bool enabled;

  @override
  final FormBloc? formBloc;

  @override
  bool get isValid => error == null;

  bool get isInitial => !isValueChanged;

  bool get hasValue => value != null;

  bool get disabled => !enabled;

  bool get isRequired => validators.contains(FieldBlocValidators.required);

  String? get displayError => isDirty ? error : null;

  FieldBlocState<Value> copyWith({
    Value? initialValue,
    Value? value,
    bool? isValueChanged,
    bool? isDirty,
    List<Validator<Value>>? validators,
    List<ValidationType>? rules,
    String? error,
    bool? enabled,
    FormBloc? formBloc,
  });

  @override
  List<Object?> get props => [
        initialValue,
        value,
        isValueChanged,
        isDirty,
        validators,
        rules,
        error,
        enabled,
        formBloc,
      ];
}

abstract class MultiFieldBlocState extends Equatable with FieldBlocStateBase {
  @override
  final String name;

  @override
  final bool isValid;

  final bool hasDisplayError;

  @override
  final FormBloc? formBloc;

  Iterable<FieldBloc> get flatFieldBlocs;

  const MultiFieldBlocState({
    required this.name,
    required this.isValid,
    required this.hasDisplayError,
    required this.formBloc,
  });

  MultiFieldBlocState copyWith({
    bool? isValid,
    bool? hasDisplayError,
    FormBloc? formBloc,
  });

  @override
  List<Object?> get props => [name, isValid, hasDisplayError, formBloc];
}

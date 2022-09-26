import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

void main() {
  final initialValue = 500;
  final invalidValue = 2000;
  final List<int> options = Iterable.generate(1000, (index) => index).toList();
  final List<int> invalidOptions =
      Iterable.generate(100, (index) => index).toList();

  test("Create1", () {
    final field = SelectFieldBloc<int>(initialValue: initialValue);

    expect(field.state.value, isNull);
  });

  test("Create2", () {
    final field =
        SelectFieldBloc<int>(initialValue: initialValue, options: options);

    expect(field.state.value, initialValue);
    expect(field.state.options, options);
  });

  test("Create3", () {
    final field = SelectFieldBloc<int>(
        initialValue: initialValue, options: invalidOptions);

    expect(field.state.value, isNull);
    expect(field.state.options, invalidOptions);
  });

  test("Change options", () {
    final field = SelectFieldBloc<int>(initialValue: initialValue);

    //
    field.changeOptions(options);

    expect(field.state.value, isNull);
    expect(field.state.options, options);

    //
    field.changeValue(initialValue);

    expect(field.state.value, initialValue);
    expect(field.state.options, options);

    //
    field.changeOptions(invalidOptions);

    expect(field.state.value, isNull);
    expect(field.state.options, invalidOptions);
  });

  test("Set invalid value", () {
    final field =
        SelectFieldBloc<int>(initialValue: initialValue, options: options);

    field.changeValue(invalidValue);

    expect(field.state.value, isNull);
    expect(field.state.options, options);
  });

  test("Requirement1", () {
    final field = SelectFieldBloc(required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNotNull);
    expect(field.state.displayError, isNull);
  });

  test("Requirement2", () {
    final field =
        SelectFieldBloc<int>(initialValue: initialValue, required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNull);
    expect(field.state.displayError, isNull);
  });
}

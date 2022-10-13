import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

void main() {
  final initialValue = [500];
  final disabledValue = [50];
  final invalidValue = [2000];
  final List<int> options = Iterable.generate(1000, (index) => index).toList();
  final List<int> disabledOptions =
      Iterable.generate(100, (index) => index).toList();
  final List<int> invalidOptions =
      Iterable.generate(100, (index) => index).toList();

  test("Create1", () {
    final field = MultiSelectFieldBloc<int>(initialValue: initialValue);

    expect(field.state.value, isEmpty);
  });

  test("Create2", () {
    final field =
        MultiSelectFieldBloc<int>(initialValue: initialValue, options: options);

    expect(field.state.value, initialValue);
    expect(field.state.options, options);
  });

  test("Create with invalid values", () {
    final field = MultiSelectFieldBloc<int>(
        initialValue: initialValue, options: invalidOptions);

    expect(field.state.value, isEmpty);
    expect(field.state.options, invalidOptions);
  });

  test("Create with invalid values 2", () {
    final field = MultiSelectFieldBloc<int>(
        initialValue: initialValue,
        options: invalidOptions,
        forceValueToSet: true);

    expect(field.state.initialValue, initialValue);
    expect(field.state.value, initialValue);
    expect(field.state.options, invalidOptions);
  });

  test("Change options", () {
    final field = MultiSelectFieldBloc<int>(initialValue: initialValue);

    //
    field.changeOptions(options);

    expect(field.state.value, isEmpty);
    expect(field.state.options, options);

    //
    field.changeValue(initialValue);

    expect(field.state.value, initialValue);
    expect(field.state.options, options);

    //
    field.changeOptions(invalidOptions);

    expect(field.state.value, isEmpty);
    expect(field.state.options, invalidOptions);
  });

  test("Set invalid value", () {
    final field =
        MultiSelectFieldBloc<int>(initialValue: initialValue, options: options);

    field.changeValue(invalidValue);

    expect(field.state.value, isEmpty);
    expect(field.state.options, options);
  });

  test("Set invalid value 2", () {
    final field = MultiSelectFieldBloc<int>(
        initialValue: initialValue, options: options, forceValueToSet: true);

    field.changeValue(invalidValue);

    expect(field.state.initialValue, initialValue);
    expect(field.state.value, invalidValue);
    expect(field.state.options, options);
  });

  test("Requirement1", () {
    final field = MultiSelectFieldBloc(required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNotNull);
    expect(field.state.displayError, isNull);
  });

  test("Requirement2", () {
    final field =
        MultiSelectFieldBloc<int>(initialValue: initialValue, required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNull);
    expect(field.state.displayError, isNull);
  });

  test("Disabled options 1", () {
    final field = MultiSelectFieldBloc<int>(
      initialValue: initialValue,
      options: options,
      disabledOptions: disabledOptions,
    );

    expect(field.state.initialValue, initialValue);
    expect(field.state.value, initialValue);
    expect(field.state.options, options);
    expect(field.state.disabledOptions, disabledOptions);

    field.changeValue(disabledValue);

    expect(field.state.value, isEmpty);

    field.clearDisabledOptions();

    expect(field.state.disabledOptions, isEmpty);

    field.changeValue(disabledValue);

    expect(field.state.value, disabledValue);
  });

  test("Disabled options 2", () {
    final field = MultiSelectFieldBloc<int>(
      initialValue: initialValue,
      options: options,
      disabledOptions: disabledOptions,
      forceValueToSet: true,
    );

    expect(field.state.initialValue, initialValue);
    expect(field.state.value, initialValue);
    expect(field.state.options, options);
    expect(field.state.disabledOptions, disabledOptions);

    field.changeValue(disabledValue);

    expect(field.state.value, disabledValue);
  });
}

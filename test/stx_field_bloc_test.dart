import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

import 'helper_test.dart';

void main() {
  group("General SingleFieldBloc tests", () {
    test("Empty state", () {
      final allFields = HelperTest.getAllEmptyFields();

      for (var field in allFields) {
        expect(field.state.name.length, 36);

        expect(field.state.initialValue, anyOf(isList, isNull));
        expect(field.state.isInitial, isTrue);

        expect(field.state.value, anyOf(isList, isNull));
        expect(field.state.hasValue, isFalse);
        expect(field.state.isValueChanged, isFalse);
        expect(field.state.isDirty, isFalse);

        expect(field.state.enabled, isTrue);
        expect(field.state.disabled, isFalse);

        //throws error // can't cast to dynamic
        //expect(field.state.validators, isNotEmpty);
        expect(field.state.isRequired, isFalse);

        expect(field.state.rules.isEmpty, isTrue);

        expect(field.state.formBloc, isNull);
        expect(field.state.hasFormBloc, isFalse);

        expect(field.state.error, isNull);
        expect(field.state.displayError, isNull);
        expect(field.state.isValid, isTrue);
        expect(field.state.isNotValid, isFalse);

        expect(field.state.extraData, isNull);
      }
    });

    test("Initial state", () {
      final enabled = false;
      final required = true;
      final customValidators = <String? Function(dynamic)>{};
      final rules = {ValidationType.onBlur};
      final extraData = 1;

      final allFields = HelperTest.getAllFieldsWithInitialValues(
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        extraData: extraData,
      );

      for (var field in allFields) {
        expect(field.state.name.length, 1);

        expect(field.state.initialValue, isNotNull);
        expect(field.state.isInitial, isTrue);

        expect(field.state.value, isNotNull);
        expect(field.state.hasValue, isTrue);
        expect(field.state.isValueChanged, isFalse);
        expect(field.state.isDirty, isFalse);

        expect(field.state.enabled, enabled);
        expect(field.state.disabled, !enabled);

        //throws error // can't cast to dynamic
        //expect(field.state.validators, isNotEmpty);
        expect(field.state.isRequired, required);

        expect(field.state.rules.isEmpty, isFalse);

        expect(field.state.formBloc, isNull);
        expect(field.state.hasFormBloc, isFalse);

        expect(field.state.error, isNull);
        expect(field.state.displayError, isNull);
        expect(field.state.isValid, isTrue);
        expect(field.state.isNotValid, isFalse);

        expect(field.state.extraData, extraData);
      }
    });

    test("Change state", () {
      var enabled = false;
      var required = true;
      var customValidators = <String? Function(dynamic)>{};
      var rules = {ValidationType.onBlur};
      var extraData = 1;

      final allFields = HelperTest.getAllFieldsWithInitialValues(
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        extraData: extraData,
      );

      enabled = !enabled;
      required = !required;
      customValidators = {};
      rules = {};
      extraData = 1;

      HelperTest.changeState(
        fields: allFields,
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        extraData: extraData,
      );

      for (var field in allFields) {
        expect(field.state.name.length, 1);

        expect(field.state.initialValue, isNotNull);
        expect(field.state.isInitial, isTrue);

        expect(field.state.value, isNotNull);
        expect(field.state.hasValue, isTrue);
        expect(field.state.isValueChanged, isFalse);
        expect(field.state.isDirty, isFalse);

        expect(field.state.enabled, enabled);
        expect(field.state.disabled, !enabled);

        //throws error // can't cast to dynamic
        //expect(field.state.validators.isEmpty, true);
        expect(field.state.isRequired, required);

        expect(field.state.rules.isEmpty, isTrue);

        expect(field.state.formBloc, isNull);
        expect(field.state.hasFormBloc, isFalse);

        expect(field.state.error, isNull);
        expect(field.state.displayError, isNull);
        expect(field.state.isValid, isTrue);
        expect(field.state.isNotValid, isFalse);

        expect(field.state.extraData, extraData);
      }
    });
  });

  group("TextFieldBloc tests", () {
    final initialValue = 'Empty';
    final updatedValue = "Updated";

    //create a field with the initial value
    test("Value1", () {
      final textField = TextFieldBloc(initialValue: initialValue);

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, initialValue);
      expect(textField.state.isInitial, isTrue);
      expect(textField.state.isValueChanged, isFalse);
    });

    //change value
    test("Value2", () {
      final textField = TextFieldBloc(initialValue: initialValue);
      textField.changeValue(updatedValue);

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, updatedValue);
      expect(textField.state.isInitial, false);
      expect(textField.state.isValueChanged, true);
    });

    //clear value
    test("Value3", () {
      final textField = TextFieldBloc(initialValue: initialValue);
      textField.clear();

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, isNull);
      expect(textField.state.isInitial, false);
      expect(textField.state.isValueChanged, true);
    });

    //reset value
    test("Value4", () {
      final textField = TextFieldBloc(initialValue: initialValue);
      textField.changeValue(updatedValue);
      textField.reset();

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, initialValue);
      expect(textField.state.isInitial, true);
      expect(textField.state.isValueChanged, false);
    });

    //create a field with the default required value
    test("Requirement1", () {
      final textField = TextFieldBloc();

      expect(textField.state.isRequired, false);
      expect(textField.state.error, null);
      expect(textField.state.displayError, null);
    });

    //create a required field
    test("Requirement2", () {
      final textField = TextFieldBloc(required: true);

      expect(textField.state.isRequired, true);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNull);
    });

    //change requirement
    test("Requirement3", () {
      final textField = TextFieldBloc();
      textField.changeRequirement(true);

      expect(textField.state.isRequired, true);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNull);
    });

    //check validation errors
    test("Requirement4", () {
      final textField =
          TextFieldBloc(initialValue: initialValue, required: true);

      expect(textField.state.isRequired, true);
      expect(textField.state.error, isNull);
      expect(textField.state.displayError, isNull);

      textField.changeValue(null);

      expect(textField.state.isRequired, isTrue);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNull);
    });

    //create a disabled field
    test("Availability1", () {
      final textField = TextFieldBloc(enabled: false);

      expect(textField.state.enabled, false);
      expect(textField.state.disabled, true);
    });

    //change value when the field is disabled
    test("Availability2", () {
      final textField =
          TextFieldBloc(initialValue: initialValue, enabled: false);
      textField.changeValue(updatedValue);

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, initialValue);
      expect(textField.state.isInitial, isTrue);
      expect(textField.state.isValueChanged, isFalse);
    });

    //force change value when the field is disabled
    test("Availability3", () {
      final textField =
          TextFieldBloc(initialValue: initialValue, enabled: false);
      textField.changeValue(updatedValue, forceChange: true);

      expect(textField.state.initialValue, initialValue);
      expect(textField.state.value, updatedValue);
      expect(textField.state.isInitial, isFalse);
      expect(textField.state.isValueChanged, isTrue);
    });

    //create a field with a rule
    test("Rules1", () {
      final textField1 =
          TextFieldBloc(required: true, rules: {ValidationType.onMounted});

      expect(textField1.state.isDirty, isTrue);
      expect(textField1.state.error, isNotNull);
      expect(textField1.state.displayError, isNotNull);

      final textField2 =
          TextFieldBloc(required: true, rules: {ValidationType.onChange});

      expect(textField2.state.isDirty, isFalse);
      expect(textField2.state.error, isNotNull);
      expect(textField2.state.displayError, isNull);

      final textField3 =
          TextFieldBloc(required: true, rules: {ValidationType.onClear});

      expect(textField3.state.isDirty, isFalse);
      expect(textField3.state.error, isNotNull);
      expect(textField3.state.displayError, isNull);

      final textField4 =
          TextFieldBloc(required: true, rules: {ValidationType.onBlur});

      expect(textField4.state.isDirty, isFalse);
      expect(textField4.state.error, isNotNull);
      expect(textField4.state.displayError, isNull);
    });

    //create a field with onChange and change value
    test("Rules2", () {
      final textField = TextFieldBloc(
        initialValue: initialValue,
        required: true,
        rules: {ValidationType.onChange},
      );
      textField.changeValue('');

      expect(textField.state.isDirty, isTrue);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNotNull);
    });

    //create a field with onBlur and change focus
    test("Rules3", () {
      final textField =
          TextFieldBloc(required: true, rules: {ValidationType.onBlur});
      textField.focusChanged();

      expect(textField.state.isDirty, isTrue);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNotNull);
    });

    //create a field with onClear and clear value
    test("Rules4", () {
      final textField = TextFieldBloc(
        initialValue: initialValue,
        required: true,
        rules: {ValidationType.onClear},
      );
      textField.clear();

      expect(textField.state.isDirty, isTrue);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNotNull);
    });

    //change rules
    test("Rules5", () {
      final textField = TextFieldBloc(required: true);
      textField.addRule(ValidationType.onMounted);
      textField.addRule(ValidationType.onMounted);
      textField.addRule(ValidationType.onMounted);
      textField.addRule(ValidationType.onMounted);

      expect(textField.state.rules.length, 1);
      expect(textField.state.isDirty, isTrue);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNotNull);

      //
      textField.removeRule(ValidationType.onMounted);

      expect(textField.state.rules.length, 0);
      expect(textField.state.isDirty, isFalse);
      expect(textField.state.error, isNotNull);
      expect(textField.state.displayError, isNull);

      //
      textField.addRules(ValidationType.values.toSet());

      expect(textField.state.rules.length, 4);

      //
      textField.removeRules(ValidationType.values.toSet());

      expect(textField.state.rules.length, 0);
    });
  });

  group("Value stream test", () {
    test("Subscription text field", () async {
      final field = TextFieldBloc();

      expect(
        field.valueStream,
        emitsInOrder(
          [null, 'test', 'test1', 'test', 'test2', emitsDone],
        ),
      );

      field.updateFormBloc(FormBloc());

      field.changeValue('test');
      field.changeValue('test');
      field.changeValue('test1');
      field.changeRequirement(true);
      field.changeValue('test1');
      field.changeValue('test');
      field.changeValue('test2');
      field.addFieldError('d');
      field.changeAvailability(true);

      field.close();
    });

    test("Subscription list field", () async {
      final field = ListFieldBloc<int>();

      expect(
        field.valueStream,
        emitsInOrder(
          [
            [],
            [1, 2],
            [2, 3],
            [1, 2],
            [3, 4],
            emitsDone
          ],
        ),
      );

      field.updateFormBloc(FormBloc());

      field.changeValue([1, 2]);
      field.changeValue([1, 2]);
      field.changeValue([2, 3]);
      field.changeRequirement(true);
      field.changeValue([2, 3]);
      field.changeValue([1, 2]);
      field.changeValue([3, 4]);
      field.addFieldError('d');
      field.changeAvailability(true);

      field.close();
    });
  });
}

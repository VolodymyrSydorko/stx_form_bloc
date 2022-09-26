import 'dart:typed_data';

import 'package:stx_form_bloc/stx_form_bloc.dart';

class HelperTest {
  HelperTest._();

  static List<SingleFieldBloc> getAllEmptyFields() {
    return [
      TextFieldBloc(),
      NumberFieldBloc(),
      DateTimeFieldBloc(),
      ListFieldBloc(),
      SelectFieldBloc(),
      MultiSelectFieldBloc(),
      ImageFieldBloc(),
      BooleanFieldBloc(),
    ];
  }

  static List<SingleFieldBloc> getAllFieldsWithInitialValues({
    required bool enabled,
    required bool required,
    required Set<String? Function(dynamic)> customValidators,
    required Set<ValidationType> rules,
    required dynamic data,
  }) {
    return [
      TextFieldBloc(
        name: '1',
        initialValue: 'Test',
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      NumberFieldBloc(
        name: '2',
        initialValue: 1,
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      DateTimeFieldBloc(
        name: '3',
        initialValue: DateTime.now(),
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      ListFieldBloc(
        name: '4',
        initialValue: [1, 3],
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      SelectFieldBloc(
        name: '5',
        initialValue: 'Test',
        options: ['Test', 'Test2'],
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      MultiSelectFieldBloc(
        name: '6',
        initialValue: [1],
        options: [1, 2],
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      ImageFieldBloc(
        name: '7',
        initialValue: Uint8List.fromList([1, 3, 4]),
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
      BooleanFieldBloc(
        name: '8',
        initialValue: true,
        enabled: enabled,
        required: required,
        customValidators: customValidators,
        rules: rules,
        data: data,
      ),
    ];
  }

  static void changeState({
    required List<SingleFieldBloc> fields,
    required bool enabled,
    required bool required,
    required Set<String? Function(dynamic)> customValidators,
    required Set<ValidationType> rules,
    required dynamic data,
  }) {
    for (var field in fields) {
      field.changeAvailability(enabled);
      field.changeRequirement(required);
      field.changeValidators(customValidators);
      field.changeRules(rules);
      field.changeData(data);
    }
  }
}

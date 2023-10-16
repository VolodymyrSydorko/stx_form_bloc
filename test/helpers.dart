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
    required bool readOnly,
    required bool required,
    required bool loading,
    required Set<String? Function(dynamic)> customValidators,
    required Set<ValidationType> rules,
    required dynamic data,
    required dynamic extraData,
  }) {
    return [
      TextFieldBloc(
        name: '1',
        initialValue: 'Test',
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      NumberFieldBloc(
        name: '2',
        initialValue: 1,
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      DateTimeFieldBloc(
        name: '3',
        initialValue: DateTime.now(),
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      ListFieldBloc(
        name: '4',
        initialValue: [1, 3],
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      SelectFieldBloc(
        name: '5',
        initialValue: 'Test',
        options: ['Test', 'Test2'],
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      MultiSelectFieldBloc(
        name: '6',
        initialValue: [1],
        options: [1, 2],
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      ImageFieldBloc(
        name: '7',
        initialValue: Uint8List.fromList([1, 3, 4]),
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
      BooleanFieldBloc(
        name: '8',
        initialValue: true,
        enabled: enabled,
        readOnly: readOnly,
        required: required,
        customValidators: customValidators,
        rules: rules,
        loading: loading,
        data: data,
        extraData: extraData,
      ),
    ];
  }

  static void changeState({
    required List<SingleFieldBloc> fields,
    required bool enabled,
    required bool readOnly,
    required bool required,
    required bool loading,
    required Set<String? Function(dynamic)> customValidators,
    required Set<ValidationType> rules,
    required dynamic data,
    required dynamic extraData,
  }) {
    for (var field in fields) {
      field.enabled = enabled;
      field.readOnly = readOnly;
      field.required = required;
      field.loading = loading;
      field.data = data;
      field.extraData = extraData;
      field.changeValidators(customValidators);
      field.changeRules(rules);
    }
  }
}

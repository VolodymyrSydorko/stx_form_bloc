import 'dart:convert';
import 'dart:typed_data';

import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';
import 'package:stx_form_bloc/src/blocs/form_bloc/form_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'image_field_state.dart';

class ImageFieldBloc extends SingleFieldBloc<Uint8List?, ImageFieldBlocState> {
  ImageFieldBloc({
    String? name,
    Uint8List? initialValue,
    bool enabled = true,
    bool? required,
    Set<Validator<Uint8List?>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
  }) : super(
          initialState: ImageFieldBlocState(
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
            data: data,
          ),
          defaultValue: null,
        );

  factory ImageFieldBloc.fromBase64String({
    String? name,
    String? initialValue,
    bool enabled = true,
    bool? required,
    Set<Validator<Uint8List?>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic data,
  }) {
    Uint8List? bytes;

    if (initialValue != null) {
      try {
        bytes = base64Decode(
          initialValue.replaceAll('data:image/png;base64,', ''),
        );
      } catch (_) {}
    } else {}

    return ImageFieldBloc(
      name: name,
      initialValue: bytes,
      enabled: enabled,
      required: required,
      customValidators: customValidators,
      rules: rules,
      data: data,
    );
  }

  @override
  String toString() {
    if (value == null) {
      return '';
    } else {
      final base64 = base64Encode(value!);

      return 'data:image/png;base64,$base64';
    }
  }
}

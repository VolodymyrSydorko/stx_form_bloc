import 'dart:convert';
import 'dart:typed_data';

import 'package:stx_form_bloc/src/blocs/input_field/input_field_bloc.dart';
import 'package:stx_form_bloc/src/validators/field_bloc_validators.dart';

part 'image_field_state.dart';

class ImageFieldBloc extends InputFieldBloc<Uint8List?> {
  ImageFieldBloc({
    super.name,
    super.initialValue,
    super.enabled,
    super.required,
    super.customValidators,
    super.rules,
    super.extraData,
  }) : super(defaultValue: null);

  factory ImageFieldBloc.fromBase64String({
    String? name,
    String? initialValue,
    bool enabled = true,
    bool? required,
    Set<Validator<Uint8List?>>? customValidators,
    Set<ValidationType> rules = const {},
    dynamic extraData,
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
      extraData: extraData,
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

part of 'text_field_bloc.dart';

typedef TextFieldBlocState = InputFieldBlocState<String?>;

extension TextFieldBlocStateX on TextFieldBlocState {
  int? get valueToInt => int.tryParse(value ?? '');

  double? get valueToDouble => double.tryParse(value ?? '');
}

// ignore_for_file: unnecessary_overrides

import 'package:bloc/bloc.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // print('onCreate -- bloc: ${bloc.runtimeType}, change: ${bloc.state}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    //print('onChange -- bloc: ${bloc.runtimeType}, change: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    //print('onError -- bloc: ${bloc.runtimeType}, error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    //print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

class LoginFormBloc extends FormBloc<String, String> {
  late TextFieldBloc email;
  late TextFieldBloc password;
  late List<TextFieldBloc> additionalFields;

  LoginFormBloc({
    String? emailData,
  }) {
    email = TextFieldBloc(
      initialValue: emailData ?? 'volodymyr@gmail.com',
      // ignore: deprecated_member_use_from_same_package
      customValidators: {FieldBlocValidators.email},
      rules: {ValidationType.onChange},
    );

    password = TextFieldBloc(
      initialValue: 'qwerty123',
      // ignore: deprecated_member_use_from_same_package
      customValidators: {FieldBlocValidators.passwordMin6Chars},
      rules: {ValidationType.onChange},
    );

    additionalFields = List.generate(
      100000,
      (index) {
        return TextFieldBloc(
          initialValue: 'qwerty123',
          // ignore: deprecated_member_use_from_same_package
          customValidators: {FieldBlocValidators.passwordMin6Chars},
          rules: {ValidationType.onChange},
        );
      },
    );

    addFields([
      email,
      password,
      ...additionalFields,
    ]);
  }

  @override
  void onSubmit() {
    emitSuccess('Ok');
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  formMain();
}

void formMain() async {
  final stopwatch = Stopwatch()..start();

  final formBloc = LoginFormBloc(emailData: 'sdcwcdscvd@dsvv.rvevr');

  print('Executed in ${stopwatch.elapsedMilliseconds}');

  stopwatch
    ..reset()
    ..start();

  print(formBloc.email.extraData);

  print('change');
  formBloc.password.changeValue('qwerty12345');

  print('reset');
  formBloc.password.reset();

  print('clear');
  formBloc.password.clear();

  print('submit');
  formBloc.submit();

  await formBloc.close();

  print('Executed in ${stopwatch.elapsedMilliseconds}');
}

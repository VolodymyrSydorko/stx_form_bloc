import 'package:bloc/bloc.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- bloc: ${bloc.runtimeType}, change: ${bloc.state}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- bloc: ${bloc.runtimeType}, change: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- bloc: ${bloc.runtimeType}');
  }
}

class LoginFormBloc extends FormBloc<String, String> {
  late TextFieldBloc email;
  late TextFieldBloc password;

  LoginFormBloc({
    String? emailData,
  }) : super() {
    email = TextFieldBloc(
      initialValue: emailData ?? 'volodymyr@gmail.com',
      customValidators: [
        FieldBlocValidators.required,
        FieldBlocValidators.email,
      ],
      rules: [ValidationType.onChange],
    );

    password = TextFieldBloc(
      initialValue: 'qwerty123',
      customValidators: [
        FieldBlocValidators.required,
        FieldBlocValidators.passwordMin6Chars
      ],
      rules: [ValidationType.onChange],
    );

    addFields([
      email,
      password,
    ]);
  }

  @override
  void onSubmit() {
    print(email.value);
    print(password.value);

    emitSuccess('Ok');
  }
}

void main() {
  BlocOverrides.runZoned(() {
    formMain();
  }, blocObserver: SimpleBlocObserver());
}

void formMain() {
  final stopwatch = Stopwatch()..start();

  final formBloc = LoginFormBloc(emailData: 'sdcwcdscvd@dsvv.rvevr');

  print('Executed in ${stopwatch.elapsedMilliseconds}');
  stopwatch
    ..reset()
    ..start();

  print('change');
  formBloc.password.changeValue('qwerty12345');

  print('reset');
  formBloc.password.reset();

  print('clear');
  formBloc.password.clear();

  print('submit');
  formBloc.submit();

  formBloc.close();

  print('Executed in ${stopwatch.elapsedMilliseconds}');
}

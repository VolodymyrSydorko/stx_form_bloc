import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';

part 'form_bloc_state.dart';
part 'form_bloc_utils.dart';

class FormBloc<SuccessResponse, FailureResponse>
    extends Cubit<FormBlocState<SuccessResponse, FailureResponse>> {
  FormBloc({
    bool isEditing = false,
    this.customSubmit = true,
  }) : super(
          FormBlocState(
            isEditing: isEditing,
          ),
        );

  final bool customSubmit;

  bool get isEditing => state.isEditing;
  bool get isCreating => !state.isEditing;

  //Checking if all fields are valid
  bool get isValid => _getFieldsStatus(fields).isValid;
  //Checking if any fields are invalid
  bool get isNotValid => !isValid;

  Map<String, FieldBloc> get fields => state.fields;

  late Stream<FormStatus> statusStream = stream
      .transform<FormStatus>(
        StreamTransformer.fromHandlers(
          handleData: (state, sink) => sink.add(state.status),
        ),
      )
      .distinct();

  List<StreamSubscription> subscriptions = [];

  FutureOr<void> initialize({Map<String, dynamic>? params}) {
    return onInitialize(params ?? {});
  }

  FutureOr<void> validate() {
    emit(_validate());
  }

  FutureOr<void> submit() async {
    validate();

    if (state.status.isValid) {
      if (customSubmit) {
        return onSubmit();
      } else {
        emitLoading();

        try {
          await onSubmit();
        } catch (error, stackTrace) {
          addError(error, stackTrace);

          emitFailure();
        }
      }
    }
  }

  FutureOr<void> cancel() {
    return onCancel();
  }

  FutureOr<void> reset() {
    emit(
      state.copyWith(
        status: FormStatus.initial,
        fields: state.fields.map(
          (key, value) => MapEntry(key, value..reset()),
        ),
      ),
    );
  }

  FutureOr<void> clear() {
    emit(
      state.copyWith(
        status: FormStatus.initial,
        fields: state.fields.map(
          (key, value) => MapEntry(key, value..clear()),
        ),
      ),
    );
  }

  void addField(FieldBloc field) => addFields([field]);
  void addFields(Iterable<FieldBloc> fields) {
    final newFields = {...state.fields};
    if (fields.isNotEmpty) {
      for (final field in fields) {
        newFields[field.name] = field..updateFormBloc(this);
      }
    }

    emit(
      state.copyWith(
        status:
            state.status.isLoading ? FormStatus.loading : FormStatus.initial,
        fields: newFields,
      ),
    );
  }

  void removeField(FieldBloc field) => removeFields([field]);
  void removeFields(Iterable<FieldBloc> fields) {
    final newFields = {...state.fields};
    if (fields.isNotEmpty) {
      for (final field in fields) {
        newFields.remove(field.name);
        field.removeFormBloc(this);
      }
    }
    emit(
      state.copyWith(
        status:
            state.status.isLoading ? FormStatus.loading : FormStatus.initial,
        fields: newFields,
      ),
    );
  }

  void addSubscription(StreamSubscription subscription) =>
      subscriptions.add(subscription);
  void addSubscriptions(Iterable<StreamSubscription> subscriptions) =>
      this.subscriptions.addAll(subscriptions);

  void cancelAllSubscriptions() {
    for (var s in subscriptions) {
      s.cancel();
    }
  }

  FutureOr<void> onInitialize(Map<String, dynamic> params) {}

  FutureOr<void> onSubmit() {}

  FutureOr<void> onCancel() {
    emitCancelled();
  }

  void emitInitial() => emit(state.copyWith(status: FormStatus.initial));
  void emitLoading() => emit(state.copyWith(status: FormStatus.loading));
  void emitSuccess(SuccessResponse response) => emit(
        state.copyWith(
          response: response,
          status: FormStatus.success,
        ),
      );
  void emitFailure([FailureResponse? error]) => emit(
        state.copyWith(
          error: error,
          status: FormStatus.failure,
        ),
      );
  void emitCancelled() => emit(state.copyWith(status: FormStatus.cancelled));

  FormStatus _getFieldsStatus(Map<String, FieldBloc> fields) {
    return fields.values.any((field) => field.state.isNotValid)
        ? FormStatus.invalid
        : FormStatus.valid;
  }

  FormBlocState<SuccessResponse, FailureResponse> _validate() {
    emit(state.copyWith(status: FormStatus.initial, isValidating: true));

    for (var field in fields.values) {
      field.validate();
    }

    return state.copyWith(
      status: _getFieldsStatus(fields),
      isValidating: false,
    );
  }

  @override
  Future<void> close() async {
    for (var f in fields.values) {
      await f.close();
    }

    cancelAllSubscriptions();

    return super.close();
  }
}

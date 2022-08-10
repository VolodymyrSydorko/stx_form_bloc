import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stx_form_bloc/src/blocs/field/field_bloc.dart';

part 'form_bloc_state.dart';
part 'form_bloc_utils.dart';

abstract class FormBloc<SuccessResponse, FailureResponse>
    extends Cubit<FormBlocState<SuccessResponse, FailureResponse>> {
  FormBloc({
    bool isEditing = false,
  }) : super(
          FormBlocState(
            isEditing: isEditing,
          ),
        );

  bool get isEditing => state.isEditing;
  bool get isCreating => !state.isEditing;

  Map<String, FieldBloc> get fields => state.fields;

  FutureOr<void> initialize({Map<String, dynamic>? params}) {
    return onInitialize(params ?? {});
  }

  FutureOr<void> validate() {
    emit(_validate());
  }

  FutureOr<void> submit() {
    emit(state.copyWith(status: FormStatus.initial, isValidating: true));
    emit(_validate());

    if (state.status.isValid) {
      emitLoading();
      return onSubmit();
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

  void addFields(Iterable<FieldBloc> fields) {
    final newFields = {...state.fields};
    if (fields.isNotEmpty) {
      for (final field in fields) {
        newFields[field.name] = field..updateFormBloc(this);
      }
    }

    emit(state.copyWith(fields: newFields));
  }

  void removeFields(Iterable<FieldBloc> fields) {
    final newFields = {...state.fields};
    if (fields.isNotEmpty) {
      for (final field in fields) {
        newFields.remove(field.name);
        field.removeFormBloc(this);
      }
    }
    emit(state.copyWith(fields: newFields));
  }

  FormBlocState<SuccessResponse, FailureResponse> _validate() {
    for (var field in fields.values) {
      field.validate();
    }

    return state.copyWith(
      status: _getFieldsStatus(fields),
      isValidating: false,
    );
  }

  FutureOr<void> onInitialize(Map<String, dynamic> params) {}

  FutureOr<void> onSubmit();

  FutureOr<void> onCancel() {
    emitCancelled();
  }

  void emitLoading() => emit(state.copyWith(status: FormStatus.loading));
  void emitInitial() => emit(state.copyWith(status: FormStatus.initial));
  void emitSuccess(SuccessResponse response) => emit(
        state.copyWith(
          response: response,
          status: FormStatus.success,
        ),
      );
  void emitFailure(FailureResponse error) => emit(
        state.copyWith(
          error: error,
          status: FormStatus.failure,
        ),
      );
  void emitCancelled() => emit(state.copyWith(status: FormStatus.cancelled));

  FormStatus _getFieldsStatus(Map<String, FieldBloc> fields) {
    return fields.values.every((field) => field.state.isValid)
        ? FormStatus.valid
        : FormStatus.invalid;
  }

  @override
  Future<void> close() async {
    for (var f in fields.values) {
      await f.close();
    }

    return super.close();
  }
}

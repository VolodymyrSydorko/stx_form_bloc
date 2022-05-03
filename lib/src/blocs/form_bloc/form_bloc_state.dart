part of 'form_bloc.dart';

enum FormStatus {
  initial,
  invalid,
  valid,
  loading,
  success,
  failure,
  cancelled
}

extension FormStatusX on FormStatus {
  bool get isInitial => FormStatus.initial == this;
  bool get isValid => FormStatus.valid == this;
  bool get isLoading => FormStatus.loading == this;
  bool get isSuccess => FormStatus.success == this;
  bool get isFailure => FormStatus.failure == this;
  bool get isInvalid => FormStatus.invalid == this;
  bool get isCancelled => FormStatus.cancelled == this;
}

class FormBlocState<SuccessResponse, FailureResponse> extends Equatable {
  final FormStatus status;
  final Map<String, FieldBloc> fields;
  final SuccessResponse? response;
  final FailureResponse? error;
  final bool isEditing;
  final bool isValidated;

  FormBlocState({
    this.status = FormStatus.initial,
    this.fields = const {},
    this.response,
    this.error,
    this.isEditing = false,
    this.isValidated = false,
  });

  FormBlocState<SuccessResponse, FailureResponse> copyWith({
    FormStatus? status,
    Map<String, FieldBloc>? fields,
    SuccessResponse? response,
    FailureResponse? error,
    bool? isEditing,
    bool? isValidated,
  }) {
    return FormBlocState<SuccessResponse, FailureResponse>(
      status: status ?? this.status,
      fields: fields ?? this.fields,
      response: response ?? this.response,
      error: error ?? this.error,
      isEditing: isEditing ?? this.isEditing,
      isValidated: isValidated ?? this.isValidated,
    );
  }

  @override
  List<Object?> get props => [
        status,
        fields,
        response,
        error,
        isEditing,
        isValidated,
      ];
}

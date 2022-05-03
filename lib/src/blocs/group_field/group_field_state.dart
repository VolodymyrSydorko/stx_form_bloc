part of 'group_field_bloc.dart';

class GroupFieldBlocState<T extends FieldBloc> extends MultiFieldBlocState {
  final List<T> fieldBlocs;

  GroupFieldBlocState({
    required String name,
    required bool isValid,
    required bool hasDisplayError,
    required this.fieldBlocs,
    FormBloc? formBloc,
  }) : super(
          name: name,
          isValid: isValid,
          hasDisplayError: hasDisplayError,
          formBloc: formBloc,
        );

  @override
  GroupFieldBlocState<T> copyWith({
    bool? isValid,
    bool? hasDisplayError,
    Object? formBloc = empty,
    List<T>? fieldBlocs,
  }) {
    return GroupFieldBlocState(
      name: name,
      isValid: isValid ?? this.isValid,
      hasDisplayError: hasDisplayError ?? this.hasDisplayError,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      fieldBlocs: fieldBlocs ?? this.fieldBlocs,
    );
  }

  @override
  Iterable<FieldBloc> get flatFieldBlocs => fieldBlocs;

  @override
  List<Object?> get props => [super.props, fieldBlocs];
}

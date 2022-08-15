part of 'group_field_bloc.dart';

class GroupFieldBlocState<T extends FieldBloc> extends MultiFieldBlocState {
  final List<T> fieldBlocs;

  GroupFieldBlocState({
    required super.name,
    required super.isValid,
    required super.hasDisplayError,
    required this.fieldBlocs,
    super.data,
    super.formBloc,
  });

  @override
  GroupFieldBlocState<T> copyWith({
    bool? isValid,
    bool? hasDisplayError,
    Object? data = empty,
    Object? formBloc = empty,
    List<T>? fieldBlocs,
  }) {
    return GroupFieldBlocState(
      name: name,
      isValid: isValid ?? this.isValid,
      hasDisplayError: hasDisplayError ?? this.hasDisplayError,
      data: data == empty ? this.data : data,
      formBloc: formBloc == empty ? this.formBloc : formBloc as FormBloc?,
      fieldBlocs: fieldBlocs ?? this.fieldBlocs,
    );
  }

  @override
  Iterable<FieldBloc> get flatFieldBlocs => fieldBlocs;

  @override
  List<Object?> get props => [super.props, fieldBlocs];
}

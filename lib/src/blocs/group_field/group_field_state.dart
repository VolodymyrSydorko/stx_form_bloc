part of 'group_field_bloc.dart';

class GroupFieldBlocState<T extends FieldBloc> extends MultiFieldBlocState {
  final List<T> fieldBlocs;

  GroupFieldBlocState({
    required super.name,
    required super.isValid,
    required super.hasDisplayError,
    required this.fieldBlocs,
    super.data,
    super.extraData,
    super.formBloc,
  });

  @override
  GroupFieldBlocState<T> copyWith({
    bool? isValid,
    bool? hasDisplayError,
    Object? data = empty,
    Object? extraData = empty,
    Object? formBloc = empty,
    List<T>? fieldBlocs,
  }) {
    return GroupFieldBlocState(
      name: name,
      isValid: isValid ?? this.isValid,
      hasDisplayError: hasDisplayError ?? this.hasDisplayError,
      data: empty == data ? this.data : data,
      extraData: empty == extraData ? this.extraData : extraData,
      formBloc: empty == formBloc ? this.formBloc : formBloc as FormBloc?,
      fieldBlocs: fieldBlocs ?? this.fieldBlocs,
    );
  }

  @override
  Iterable<FieldBloc> get flatFieldBlocs => fieldBlocs;

  @override
  List<Object?> get props => [super.props, fieldBlocs];
}

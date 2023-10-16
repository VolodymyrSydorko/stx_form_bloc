import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:uuid/uuid.dart';

part 'group_field_state.dart';

class GroupFieldBloc<T extends FieldBloc>
    extends MultiFieldBloc<GroupFieldBlocState<T>> {
  GroupFieldBloc({
    String? name,
    List<T> fieldBlocs = const [],
    dynamic data,
    dynamic extraData,
  }) : super(
          GroupFieldBlocState(
            name: name ?? Uuid().v1(),
            isValid: FormBlocUtils.isValid(fieldBlocs),
            hasDisplayError: MultiFieldBloc.deepHasDisplayError(fieldBlocs),
            fieldBlocs: fieldBlocs,
            data: data,
            extraData: extraData,
          ),
        );

  List<T> get fields => state.fieldBlocs;

  void addFieldBloc(T fieldBloc) => addFieldBlocs([fieldBloc]);
  void addFieldBlocs(List<T> fieldBlocs) {
    if (fieldBlocs.isNotEmpty) {
      final nextFieldBlocs = [...state.fieldBlocs, ...fieldBlocs];

      emit(state.copyWith(
        fieldBlocs: nextFieldBlocs,
      ));

      FormBlocUtils.updateFormBloc(
        fieldBlocs: fieldBlocs,
        formBloc: state.formBloc,
      );
    }
  }

  setFieldBlocs(List<T> fieldBlocs) {
    emit(state.copyWith(
      fieldBlocs: [...fieldBlocs],
    ));
  }

  void removeFieldBlocAt(int index) {
    if (state.fieldBlocs.length > index) {
      final nextFieldBlocs = [...state.fieldBlocs];
      final fieldBlocRemoved = nextFieldBlocs.removeAt(index);

      emit(state.copyWith(
        fieldBlocs: nextFieldBlocs,
      ));

      FormBlocUtils.removeFormBloc(
        fieldBlocs: [fieldBlocRemoved],
        formBloc: state.formBloc,
      );
    }
  }

  void removeFieldBloc(FieldBloc fieldBloc) =>
      removeFieldBlocsWhere((fb) => fieldBloc == fb);

  void removeFieldBlocs(Iterable<FieldBloc> fieldBlocs) =>
      removeFieldBlocsWhere(fieldBlocs.contains);

  void removeFieldBlocsWhere(bool Function(T element) test) {
    final nextFieldBlocs = [...state.fieldBlocs];
    final fieldBlocsRemoved = <T>[];

    nextFieldBlocs.removeWhere((e) {
      if (test(e)) {
        fieldBlocsRemoved.add(e);
        return true;
      }
      return false;
    });

    if (fieldBlocsRemoved.isEmpty) return;

    emit(state.copyWith(
      fieldBlocs: nextFieldBlocs,
    ));

    FormBlocUtils.removeFormBloc(
      fieldBlocs: fieldBlocsRemoved,
      formBloc: state.formBloc,
    );
  }
}

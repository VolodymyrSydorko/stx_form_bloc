import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

void main() {
  test("Initial state1", () {
    final groupField = GroupFieldBloc();

    expect(groupField.state.fieldBlocs, isEmpty);
  });

  test("Initial state2", () {
    final field = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field]);

    expect(groupField.state.fieldBlocs.length, 1);
  });

  test("Add and insert field bloc", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();

    final groupField = GroupFieldBloc()..addFieldBloc(field1);

    expect(groupField.state.fieldBlocs.length, 1);

    groupField.addFieldBloc(field2);

    expect(groupField.state.fieldBlocs.length, 2);
    expect(groupField.state.fieldBlocs.first, field1);
    expect(groupField.state.fieldBlocs.last, field2);

    groupField.insertFieldBloc(0, field3);

    expect(groupField.state.fieldBlocs.length, 3);
    expect(groupField.state.fieldBlocs[0], field3);
    expect(groupField.state.fieldBlocs[1], field1);
    expect(groupField.state.fieldBlocs[2], field2);
  });

  test("Add and insert field blocs", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final field4 = TextFieldBloc();

    final groupField = GroupFieldBloc()..addFieldBlocs([field2, field1]);

    expect(groupField.state.fieldBlocs.length, 2);
    expect(groupField.state.fieldBlocs.first, field2);
    expect(groupField.state.fieldBlocs.last, field1);

    groupField.insertFieldBlocs(0, [field4, field3]);

    expect(groupField.state.fieldBlocs.length, 4);
    expect(groupField.state.fieldBlocs[0], field4);
    expect(groupField.state.fieldBlocs[1], field3);
    expect(groupField.state.fieldBlocs[2], field2);
    expect(groupField.state.fieldBlocs[3], field1);
  });

  test("Set field blocs", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final field4 = TextFieldBloc();

    final groupField = GroupFieldBloc()..addFieldBlocs([field1, field2]);

    expect(groupField.state.fieldBlocs.length, 2);
    expect(groupField.state.fieldBlocs.first, field1);
    expect(groupField.state.fieldBlocs.last, field2);

    groupField.setFieldBlocs([field4, field3, field2, field1]);

    expect(groupField.state.fieldBlocs.length, 4);
    expect(groupField.state.fieldBlocs[0], field4);
    expect(groupField.state.fieldBlocs[1], field3);
    expect(groupField.state.fieldBlocs[2], field2);
    expect(groupField.state.fieldBlocs[3], field1);
  });

  test("Remove field bloc", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1, field2]);

    expect(groupField.state.fieldBlocs.length, 2);

    groupField.removeFieldBloc(field1);

    expect(groupField.state.fieldBlocs.length, 1);
    expect(groupField.state.fieldBlocs.first, field2);
  });

  test("Remove field blocs", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1, field2, field3]);

    expect(groupField.state.fieldBlocs.length, 3);

    groupField.removeFieldBlocs([field1, field2]);

    expect(groupField.state.fieldBlocs.length, 1);
    expect(groupField.state.fieldBlocs.first, field3);
  });

  test("Remove field blocs where", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1, field2, field3]);

    expect(groupField.state.fieldBlocs.length, 3);

    groupField
        .removeFieldBlocsWhere((field) => [field1, field2].contains(field));

    expect(groupField.state.fieldBlocs.length, 1);
    expect(groupField.state.fieldBlocs.first, field3);
  });

  test("Remove field blocs at", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1, field2, field3]);

    expect(groupField.state.fieldBlocs.length, 3);

    groupField
      ..removeFieldBlocAt(1)
      ..removeFieldBlocAt(0);

    expect(groupField.state.fieldBlocs.length, 1);
    expect(groupField.state.fieldBlocs.first, field3);
  });

  test("Remove all field blocs", () {
    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1, field2, field3]);

    expect(groupField.state.fieldBlocs.length, 3);

    groupField.removeAllFieldBlocs();

    expect(groupField.state.fieldBlocs.length, 0);
  });

  test("Validation1", () {
    final field1 = TextFieldBloc(required: true);
    final groupField = GroupFieldBloc(fieldBlocs: [field1]);

    expect(groupField.state.isValid, false);

    field1.changeValue('test');
    groupField.validate();

    expect(groupField.state.isValid, true);
  });

  test("Validation2", () {
    final field1 = TextFieldBloc(required: true, initialValue: 'test');
    final groupField = GroupFieldBloc(fieldBlocs: [field1]);

    expect(groupField.state.isValid, true);

    field1.changeValue('');
    groupField.validate();

    expect(groupField.state.isValid, false);
  });

  test("FormBloc property", () {
    final formBloc = FormBloc();

    final field1 = TextFieldBloc();
    final field2 = TextFieldBloc();
    final field3 = TextFieldBloc();
    final groupField = GroupFieldBloc(fieldBlocs: [field1]);

    expect(field1.state.formBloc, isNull);

    groupField.updateFormBloc(formBloc);

    expect(field1.state.formBloc, formBloc);

    groupField.addFieldBloc(field2);

    expect(field2.state.formBloc, formBloc);

    groupField.insertFieldBloc(2, field3);

    expect(field1.state.formBloc, formBloc);
    expect(field2.state.formBloc, formBloc);
    expect(field3.state.formBloc, formBloc);

    groupField.removeFieldBloc(field1);

    expect(field1.state.formBloc, isNull);
    expect(field2.state.formBloc, formBloc);
    expect(field3.state.formBloc, formBloc);

    groupField.removeFieldBlocAt(0);

    expect(field1.state.formBloc, isNull);
    expect(field2.state.formBloc, isNull);
    expect(field3.state.formBloc, formBloc);

    groupField.removeFieldBlocsWhere((_) => false);

    expect(field1.state.formBloc, isNull);
    expect(field2.state.formBloc, isNull);
    expect(field3.state.formBloc, formBloc);

    groupField.setFieldBlocs([]);

    expect(field1.state.formBloc, isNull);
    expect(field2.state.formBloc, isNull);
    expect(field3.state.formBloc, isNull);

    groupField.setFieldBlocs([field1, field2, field3]);

    expect(field1.state.formBloc, formBloc);
    expect(field2.state.formBloc, formBloc);
    expect(field3.state.formBloc, formBloc);

    final formBloc2 = FormBloc();
    groupField.updateFormBloc(formBloc2);

    expect(field1.state.formBloc, formBloc2);
    expect(field2.state.formBloc, formBloc2);
    expect(field3.state.formBloc, formBloc2);
  });
}

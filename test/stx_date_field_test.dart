import 'package:intl/intl.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

void main() {
  test("Requirement1", () {
    final field = DateTimeFieldBloc(required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNotNull);
    expect(field.state.displayError, isNull);
  });

  test("Requirement2", () {
    final field =
        DateTimeFieldBloc(initialValue: DateTime.now(), required: true);

    expect(field.state.isRequired, isTrue);
    expect(field.state.error, isNull);
    expect(field.state.displayError, isNull);
  });

  test("DateFormat1", () {
    final field = DateTimeFieldBloc(
      dateFormat: DateFormat(DateFormat.MONTH_DAY),
    );

    expect(field.state.toNullableString(), isNull);
    expect(field.state.toString(), '');
  });

  test("DateFormat2", () {
    final field = DateTimeFieldBloc(
      initialValue: DateTime(2022, 9, 27),
      dateFormat: DateFormat(DateFormat.MONTH_DAY),
    );

    expect(field.state.toNullableString(), 'September 27');
    expect(field.state.toString(), 'September 27');
  });
}

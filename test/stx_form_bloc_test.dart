import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';
import 'package:test/test.dart';

// @GenerateNiceMocks([MockSpec<StreamSubscription>()])
// import 'stx_form_bloc_test.mocks.dart';

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  group("FormBloc fields test ", () {
    blocTest(
      "Initial fields",
      build: () => FormBloc(),
      verify: (bloc) {
        expect(bloc.fields.length, 0);
      },
    );

    blocTest(
      "Add fields",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addField(TextFieldBloc());
        bloc.addFields([
          TextFieldBloc(),
          TextFieldBloc(),
        ]);
      },
      verify: (bloc) {
        expect(bloc.fields.length, 3);
      },
    );

    blocTest(
      "Keep loading status when add/remove field",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.emitLoading();

        bloc.addField(TextFieldBloc());
      },
      verify: (bloc) {
        expect(bloc.state.status, FormStatus.loading);
        expect(bloc.fields.length, 1);
      },
    );
  });

  group("FormBloc subscription test ", () {
    late List<MockStreamSubscription> subscriptions;

    setUp(() {
      subscriptions = [
        MockStreamSubscription(),
        MockStreamSubscription(),
        MockStreamSubscription(),
      ];

      for (var sub in subscriptions) {
        when(() => sub.cancel()).thenAnswer((_) => Future.value());
      }
    });

    blocTest(
      "Subscription 1",
      build: () => FormBloc(),
      verify: (bloc) {
        expect(bloc.subscriptions.length, 0);
      },
    );

    blocTest(
      "Subscription 2",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addSubscription(subscriptions.first);
      },
      verify: (bloc) {
        expect(bloc.subscriptions.length, 1);
      },
    );

    blocTest(
      "Subscription 3",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addSubscriptions(subscriptions);
      },
      verify: (bloc) {
        expect(bloc.subscriptions.length, 3);
      },
    );

    blocTest(
      "Subscription 4",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addSubscription(subscriptions.first);
        bloc.addSubscriptions(subscriptions);
      },
      verify: (bloc) {
        expect(bloc.subscriptions.length, 4);
      },
    );

    blocTest(
      "Subscription 5",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addSubscriptions(subscriptions);
      },
      verify: (bloc) {
        for (var sub in bloc.subscriptions) {
          verify(() => sub.cancel()).called(1);
        }
      },
    );

    blocTest(
      "Subscription 6",
      build: () => FormBloc(),
      act: (bloc) {
        bloc.addSubscriptions(subscriptions);
        bloc.cancelAllSubscriptions();
      },
      verify: (bloc) {
        for (var sub in bloc.subscriptions) {
          verify(() => sub.cancel()).called(2);
        }
      },
    );
  });
}

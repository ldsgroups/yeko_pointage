// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yeko_pointage/commons/commons.dart';
import 'package:yeko_pointage/features/auth/business/entities/user_entity.dart';
import 'package:yeko_pointage/features/auth/presentation/presentation.dart';
import 'package:yeko_pointage/main.dart';

void main() {
  // Checking initial page
  group('CoreApp', () {
    testWidgets('Should show LoadingPage when authState is loading',
        (tester) async {
      await tester.pumpWidget(const ProviderScope(child: CoreApp()));

      expect(find.byType(LoadingPage), findsOneWidget);
    });

    testWidgets(
        'Should show SignInPage when authState is data and user is null',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => null),
          ],
          child: const CoreApp(),
        ),
      );

      expect(find.byType(SignInPage), findsOneWidget);
    });

    testWidgets(
        'Should show LockingPage when authState is data and user is not null',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) {
              return UserEntity(
                id: 'id',
                email: 'email',
                phone: 'phone',
                lastSignInAt: DateTime.now().toIso8601String(),
              );
            }),
          ],
          child: const CoreApp(),
        ),
      );

      expect(find.byType(LockingPage), findsOneWidget);
    });
  });

  // SignIn
  group('SignIn', () {
    testWidgets('Should success login user then redirect to LockingPage',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => null),
          ],
          child: const CoreApp(),
        ),
      );

      // Check if is sign in page and connect button exist
      expect(find.text('Se connecter'), findsOneWidget);

      // first input with email hint text
      await tester.tap(find.byType(TextFormField));
      tester.testTextInput.enterText('kassidarius@gmail.com');

      // last input with password int text
    });
  });
}

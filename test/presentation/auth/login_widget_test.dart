import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kototinder/presentation/screens/auth/login_screen.dart';
import 'package:kototinder/presentation/viewmodels/auth_viewmodel.dart';

import 'package:kototinder/domain/usecases/login.dart';
import 'package:kototinder/domain/usecases/register.dart';
import 'package:kototinder/domain/usecases/complete_onboarding.dart';
import 'package:kototinder/domain/usecases/init_auth.dart';

class MockLogin extends Mock implements Login {}
class MockRegister extends Mock implements Register {}
class MockCompleteOnboarding extends Mock implements CompleteOnboarding {}
class MockInitAuth extends Mock implements InitAuth {}

void main() {
  testWidgets('invalid login shows error', (tester) async {
    final mockLogin = MockLogin();
    final mockRegister = MockRegister();
    final mockComplete = MockCompleteOnboarding();
    final mockInit = MockInitAuth();

    when(() => mockInit()).thenAnswer(
      (_) async => InitAuthResult(
        isLoggedIn: false,
        onboardingCompleted: false,
      ),
    );

    when(() => mockLogin(any(), any()))
        .thenThrow(Exception('Invalid credentials'));

    final viewModel = AuthViewModel(
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      completeOnboardingUseCase: mockComplete,
      initAuth: mockInit,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // ВАЖНО: валидные данные формы
    await tester.enterText(
        find.byType(TextFormField).at(0), 'wrong@mail.com');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'password123'); // >= 6 символов

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.textContaining('Invalid credentials'), findsOneWidget);

    // Дополнительно можно проверить что usecase вызвался
    verify(() => mockLogin(any(), any())).called(1);
  });
}
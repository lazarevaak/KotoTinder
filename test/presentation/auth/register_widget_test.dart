import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:kototinder/presentation/screens/auth/login_screen.dart';

import 'package:kototinder/presentation/viewmodels/auth_viewmodel.dart';

import 'package:kototinder/domain/usecases/login.dart';
import 'package:kototinder/domain/usecases/register.dart';
import 'package:kototinder/domain/usecases/complete_onboarding.dart';
import 'package:kototinder/domain/usecases/init_auth.dart';

import '../../helpers/test_app_wrapper.dart';

class MockLogin extends Mock implements Login {}
class MockRegister extends Mock implements Register {}
class MockCompleteOnboarding extends Mock implements CompleteOnboarding {}
class MockInitAuth extends Mock implements InitAuth {}

void main() {
  testWidgets('successful login changes state', (tester) async {
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
        .thenAnswer((_) async {});

    final viewModel = AuthViewModel(
      loginUseCase: mockLogin,
      registerUseCase: mockRegister,
      completeOnboardingUseCase: mockComplete,
      initAuth: mockInit,
    );

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: testAppWrapper(const LoginScreen()),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'test@mail.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton));

    await tester.pump();

    expect(viewModel.isLoggedIn, true);
  });
}
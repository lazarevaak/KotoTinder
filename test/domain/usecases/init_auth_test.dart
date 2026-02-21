// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kototinder/domain/usecases/init_auth.dart';
import 'package:kototinder/domain/usecases/check_auth_status.dart';
import 'package:kototinder/domain/usecases/check_onboarding_status.dart';

class MockCheckAuthStatus extends Mock implements CheckAuthStatus {}
class MockCheckOnboardingStatus extends Mock implements CheckOnboardingStatus {}

void main() {
  late MockCheckAuthStatus mockCheckAuth;
  late MockCheckOnboardingStatus mockCheckOnboarding;
  late InitAuth initAuth;

  setUp(() {
    mockCheckAuth = MockCheckAuthStatus();
    mockCheckOnboarding = MockCheckOnboardingStatus();

    initAuth = InitAuth(mockCheckAuth, mockCheckOnboarding);
  });

  test('returns correct auth + onboarding state', () async {
    when(() => mockCheckAuth()).thenAnswer((_) async => true);
    when(() => mockCheckOnboarding()).thenAnswer((_) async => false);

    final result = await initAuth();

    expect(result.isLoggedIn, true);
    expect(result.onboardingCompleted, false);
  });
}
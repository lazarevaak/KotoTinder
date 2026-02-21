import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kototinder/domain/usecases/register.dart';

import '../mocks/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late Register register;

  setUp(() {
    repository = MockAuthRepository();
    register = Register(repository);
  });

  test('calls repository register on success', () async {
    when(() => repository.register(any(), any()))
        .thenAnswer((_) async {});

    await register('test@mail.com', 'password');

    verify(() => repository.register('test@mail.com', 'password')).called(1);
  });

  test('throws exception on register failure', () async {
    when(() => repository.register(any(), any()))
        .thenThrow(Exception('Registration failed'));

    expect(
      () => register('bad', '123'),
      throwsException,
    );
  });
}
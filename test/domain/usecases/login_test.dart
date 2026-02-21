import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kototinder/domain/usecases/login.dart';

import '../mocks/mock_auth_repository.dart';

void main() {
  late MockAuthRepository repository;
  late Login login;

  setUp(() {
    repository = MockAuthRepository();
    login = Login(repository);
  });

  test('calls repository login', () async {
    when(() => repository.login(any(), any()))
        .thenAnswer((_) async {});

    await login('test@mail.com', 'password');

    verify(() => repository.login('test@mail.com', 'password')).called(1);
  });
}
import 'dart:math';

import 'package:my_notes/code_repeat.dart';
import 'package:my_notes/services/auth/auth_exception.dart';
import 'package:my_notes/services/auth/auth_provider.dart';
import 'package:my_notes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(
        provider.isInitialized,
        false,
      );
    });

    test("Can't log out if not initialized", () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedExcepttion>()),
      );
    });
  });
}

class NotInitializedExcepttion implements Exception {}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  AuthUser? _user;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    // createUser
    if (!isInitialized) throw NotInitializedExcepttion();
    CodeRepeat().waiting(1);

    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  // currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    // initialize
    CodeRepeat().waiting(1);
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    // logIn
    if (!isInitialized) throw NotInitializedExcepttion();
    if (email == "first.last@email.com") throw UserNotFoundAuthException();
    if (password == "password") throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;

    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    // logOut
    if (!isInitialized) throw NotInitializedExcepttion();
    if (_user == null) throw UserNotFoundAuthException();
    CodeRepeat().waiting(1);
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    // sendEmailVerification
    if (!isInitialized) throw NotInitializedExcepttion();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}

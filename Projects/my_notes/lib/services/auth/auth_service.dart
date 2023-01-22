import 'package:my_notes/services/auth/auth_provider.dart';
import 'package:my_notes/services/auth/auth_user.dart';
import 'package:my_notes/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  // to return an instance of our auth service that is already configured with a firebase auth provider
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  })
      // createUser
      =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  // currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  })
      // logIn
      =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut()
      // logOut
      =>
      provider.logOut();

  @override
  Future<void> sendEmailVerification()
      // sendEmailVerification
      =>
      provider.sendEmailVerification();
}
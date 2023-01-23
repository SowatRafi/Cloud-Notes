/* Login Exceptions */

// user not found!
class UserNotFoundAuthException implements Exception {}

// wrong password!
class WrongPasswordAuthException implements Exception {}

/* Registration Exceptions */

// weak password
class WeakPasswordAuthException implements Exception {}

// email already in use
class EmailAlreadyInUseAuthException implements Exception {}

// invalid email
class InvalidEmailAuthException implements Exception {}

/* Generic Exceptions */

class GenericAuthException implements Exception {}

// user not logged in
class UserNotLoggedInAuthException implements Exception {}

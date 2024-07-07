
abstract class AuthEvents{}

class LoginEvent extends AuthEvents{
  final String email;
  final String password;

  LoginEvent({required this.email,required this.password});

}

class RegusterEvent extends AuthEvents{}
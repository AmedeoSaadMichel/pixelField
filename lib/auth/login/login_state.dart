import 'package:pixelfield/auth/form_submission_status.dart';

class LoginState{
  final String email;
  //condition validation email
  bool get isValidEmail => email.isNotEmpty && email.contains('@');
  final String password;
  //condition validation password
  bool get isValidPassword => password.isNotEmpty && password.length >=8;
  final FormSubmissionStatus formStatus;

  LoginState({
    this.email='',
    this.password='',
    this.formStatus = const InitialFormStatus(),
});

  LoginState copyWith({
     String? email,
     String? password,
     FormSubmissionStatus? formStatus,
}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield/auth/login/login_event.dart';
import 'package:pixelfield/auth/login/login_state.dart';
import 'package:pixelfield/auth/form_submission_status.dart';
import 'package:pixelfield/auth/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState()){
    on<LoginEvent>((event, emit) => _onEvent(event,emit));
  }


  FutureOr<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginEmailChanged) {
      //email updated
      emit.call(state.copyWith(email: event.email));
     //  state.copyWith(email: event.email);
    } else if (event is LoginPasswordChanged) {
      //password updated
      emit.call(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      //form submitted
      emit.call(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.login();
        emit.call( state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit.call( state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }
/*  Stream<LoginState> mapEventToState(LoginEvent event) async* {

  }*/
}

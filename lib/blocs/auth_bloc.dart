

import 'package:chatapp/blocs/auth_events.dart';
import 'package:chatapp/blocs/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents,AuthState>{
  AuthBloc():super(AuthInitial()){
    on<AuthEvents>((event, emit)async{

      if(event is LoginEvent){


          emit(LoginLoading());

          try {
            UserCredential user = await FirebaseAuth.instance.
            signInWithEmailAndPassword(email: event.email, password: event.password);
            emit(LoginSuccess());
          } on FirebaseAuthException catch (ex) {
            if (ex.code == 'user-not-found') {
              emit(LoginFailure(errorMessage: 'user-not-found'));
            } else if (ex.code == 'wrong-password') {
              emit(LoginFailure(errorMessage: 'wrong-password'));
            }
          } catch (e) {
            emit(LoginFailure(errorMessage:'somthing went wrong' ));
          }

      }

    });
  }

  @override
  void onTransition(Transition<AuthEvents, AuthState> transition) {

    super.onTransition(transition);

    print(transition);
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);

    print(change);
  }

}
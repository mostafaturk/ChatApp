

import 'package:chatapp/cubits/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitial());


  Future<void> loginUser({required email,required password}) async {
    
    emit(LoginLoading());
    
    try {
      UserCredential user = await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email, password: password);
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

}
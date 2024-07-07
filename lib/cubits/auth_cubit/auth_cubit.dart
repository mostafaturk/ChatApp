

import 'package:chatapp/cubits/auth_cubit/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit():super(AuthInitial());

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

  Future<void> registerUser({required email,required password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak-password'));

      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email-already-in-use'));



      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'ther was an error please try again'));
    }
  }

}
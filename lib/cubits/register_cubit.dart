

import 'package:chatapp/cubits/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitial());

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
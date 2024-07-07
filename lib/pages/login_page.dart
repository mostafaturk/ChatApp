import 'package:chatapp/blocs/auth_bloc.dart';
import 'package:chatapp/blocs/auth_events.dart';
//import 'package:chatapp/cubits/auth_cubit/auth_cubit.dart';
//import 'package:chatapp/cubits/auth_cubit/auth_states.dart';
import 'package:chatapp/cubits/chat_cubit.dart';
//import 'package:chatapp/cubits/login_cubit.dart';
//import 'package:chatapp/cubits/login_states.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../blocs/auth_states.dart';
import '../consts.dart';
import '../widget/customButton.dart';
import '../widget/custom_text_field.dart';
import 'chat_page.dart';




class Login extends StatelessWidget {
  static String id='login';
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  @override
  Widget build(BuildContext context){
    return  BlocListener<AuthBloc,AuthState>(
      listener: (context,state){
        if(state is LoginLoading){
          isLoading=true;
        }else if(state is LoginSuccess){
          BlocProvider.of<ChatCubit>(context).getMessages();
          isLoading=false;
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
        }else if(state is LoginFailure){
          showsnackbar(context, state.errorMessage);
          isLoading=false;

        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            backgroundColor: kprimarycolor,
            //appBar: AppBar(),
            //drawer: Drawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 75,),

                        Image.asset("assets/images/scholar.png"),
                        Text("Scolar chat",
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: "Pacifico",
                            color: Colors.white,

                          ),
                        ),
                        SizedBox(height: 75,),

                        Row(
                          children: [
                            Text("login",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        customtextformfield(
                          onChange: (data){
                            email=data;
                          },
                          hintText: "Email",
                        ),
                        const SizedBox(height: 20,),

                        customtextformfield(
                          obscureText: true,
                          onChange: (data){
                            password=data;
                          },
                          hintText: "Password",
                        ),
                        const SizedBox(height: 20,),

                        customButton(
                          ontap: () async{
                            if(formKey.currentState!.validate()){
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent
                            (email: email!, password: password!));
                          
                            }


                          },
                          text: "Login",
                        ),
                        const SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("already have account",
                                style: TextStyle(
                                    color: Colors.white
                                )
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, Register.id);
                              },
                              child: Text("Register",
                                style: TextStyle(
                                    color:Color(0xffC7EDE6)
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance.
    signInWithEmailAndPassword(email: email!, password: password!);
  }

  void showsnackbar(BuildContext context,String message){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text(message),),);
  }
}

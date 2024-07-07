import 'package:chatapp/cubits/auth_cubit/auth_cubit.dart';
import 'package:chatapp/cubits/auth_cubit/auth_states.dart';
//import 'package:chatapp/cubits/register_cubit.dart';
//import 'package:chatapp/cubits/register_states.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../consts.dart';
import '../widget/customButton.dart';
import '../widget/custom_text_field.dart';






class Register extends StatelessWidget{
  static String id='register';
  String? email;

  String? password;

  bool isloading= false;


  GlobalKey<FormState> formkey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthCubit,AuthState>(
      listener: (context,state){
        if(state is RegisterLoading){
          isloading=true;
        }else if(state is RegisterSuccess){
          isloading=false;
          Navigator.pushNamed(context, ChatPage.id,arguments: email);
        }else if(state is RegisterFailure){
          showsnackbar(context, state.errorMessage);
          isloading=false;

        }

      },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
            backgroundColor: kprimarycolor,
            //appBar: AppBar(),
            //drawer: Drawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formkey,
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
                            Text("Register",
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
                          onChange: (data){
                            password=data;
                          },
                          hintText: "Password",
                        ),
                        const SizedBox(height: 20,),

                        customButton(
                          ontap: () async{
                        if(formkey.currentState!.validate()){
                        BlocProvider.of<AuthCubit>(context).registerUser
                          (email: email!, password: password!);
                        }


                          },
                          text: "REGISTER",
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
                                Navigator.pop(context);
                              },
                              child: Text("Login",
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance.
    createUserWithEmailAndPassword(email: email!, password: password!);
  }

  void showsnackbar(BuildContext context,String message){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text(message),),);
  }
}


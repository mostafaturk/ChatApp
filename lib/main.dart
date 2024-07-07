
import 'package:chatapp/blocs/auth_bloc.dart';
import 'package:chatapp/cubits/auth_cubit/auth_cubit.dart';
import 'package:chatapp/cubits/chat_cubit.dart';
//import 'package:chatapp/cubits/login_cubit.dart';
//import 'package:chatapp/cubits/register_cubit.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/simole_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp( MyApp()) ;
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context)=> LoginCubit()),
        // BlocProvider(create: (context)=> RegisterCubit()),
        BlocProvider(create: (context)=>AuthCubit()),
        BlocProvider(create: (context)=> AuthBloc()),

        BlocProvider(create: (context)=> ChatCubit()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home:login() ,
        theme: ThemeData(
          //fontFamily: "NotoSerif",
            primaryColor: Colors.red,
            //buttonColor: Colors.cyan
            textTheme: TextTheme(
                titleLarge:TextStyle(color: Colors.red,fontSize: 30)

            )
        ),
        routes: {
          Login.id:(context)=>Login(),
          Register.id:(context)=>Register(),
          ChatPage.id:(context)=>ChatPage(),



        },
        initialRoute: "login",

      ),
    );
  }
}
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body: Center(
          child:GestureDetector(

              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child:
                Text("mostafa"),
              ),
              onTapUp: (tap){

                print("sasa");
              }, onTapDown: (tap){
            print("adel");


          },
              onTapCancel: (){

                print("cansel");

              }


          )
          ,
        )
    );
  }
}


































// import 'package:flutter/material.dart';
//
// class name extends StatefulWidget{
//
//   name({Key? Key }) : super(key: Key);
//   @override
//   _nameState createState() => _nameState();
//
//
// }
//
// class _nameState extends State<name>{
//
//   bool notify=false;
//
//
//   GlobalKey<ScaffoldState> scaffoldkey =new GlobalKey<ScaffoldState>();
//
// // void showsnackbar(BuildContext context){
// //   final snackbar=SnackBar(content: Text("welcome mostafa"),
// //     duration: Duration(seconds: 3),
// //     padding: EdgeInsets.all(20),
// //     backgroundColor: Colors.blueAccent,
// //     behavior: SnackBarBehavior.floating,
// //     margin: EdgeInsets.all(30),
// //     onVisible: (){print("ahmos");},
// //     action: SnackBarAction( textColor:Colors.red , label: "close",onPressed: (){print("omkos");},),
// //   );
// //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
// // }
//   List mobile=[
//     {
//       "name":"sasa1",
//       "scren":"sasa2",
//       "cpu":"sasa3"
//     }, {
//       "name":"sasa4",
//       "scren":"sasa5",
//       "cpu":"sasa6"
//     }, {
//       "name":"sasa7",
//       "scren":"sasa8",
//       "cpu":"sasa9"
//     },{
//       "name":"sasa7",
//       "scren":"sasa8",
//       "cpu":"sasa9"
//     }
//   ];
//   List user=["mostafa","adel","abdallah","ahmed "];
//   @override
//   Widget build(BuildContext context){
//
//     return Scaffold(
//         key: scaffoldkey,
//         appBar: AppBar(),
//         drawer: Drawer(),
//         body: Container(
//           margin: EdgeInsets.all(10),
//           child: GridView(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10),
//             children: List.generate(user.length, (i) {
//
//               return Container(height: 200, color: Colors.red, child: Text("${user[i]}"),);
//
//             }
//
//             )
//
//             ,
//           ),
//
//         )
//     );
//
//
//   }
// }



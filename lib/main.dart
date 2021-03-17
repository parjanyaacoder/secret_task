import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/LoginPage.dart';
import 'package:internship_app/SecretPage.dart';
import 'package:internship_app/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home':(c) => MyInternshipApp(),
        'Login':(c) => LoginPage(),
        'Secret':(c) => SecretPage(),
      },
      home: ChangeNotifierProvider<GoogleSignInProvider>(create: (context) => GoogleSignInProvider(),child: MyInternshipApp()),
    );
  }
}
class MyInternshipApp extends StatefulWidget {
  @override
  _MyInternshipAppState createState() => _MyInternshipAppState();
}

class _MyInternshipAppState extends State<MyInternshipApp> {

  @override
  void initState() {
    Provider.of<GoogleSignInProvider>(context,listen: false);
    super.initState();
  }

  Future getProvider() async {
    return  Provider.of<GoogleSignInProvider>(context,listen: false);
  }

  // Widget startScreen ()
  // {
  //   if(Provider.of<GoogleSignInProvider>(context,listen: false).googleSignIn.currentUser != null)
  //     return SecretPage();
  //   return LoginPage();
  // }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getProvider(),
        builder: (BuildContext context,snapshot) {
        return  Provider.of<GoogleSignInProvider>(context,listen: false).googleSignIn.currentUser != null
            ?  SecretPage() : LoginPage();
        },
        );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/LoginPage.dart';
import 'package:internship_app/SecretPage.dart';
import 'package:internship_app/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences pref;

  @override
  void initState(){
  checkLogin();
    super.initState();
  }


  Future checkLogin() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLogin(),
        builder: (BuildContext context,snapshot) {

        if(pref != null &&  pref.getString('currentUserId') != null )
          return SecretPage();
        return LoginPage();

        },
        );
  }
}

import 'package:flutter/material.dart';
import 'package:internship_app/LoginPage.dart';
import 'package:internship_app/google_sign_in.dart';
import 'package:internship_app/main.dart';
import 'package:provider/provider.dart';
class SecretPage extends StatefulWidget {
  @override
  _SecretPageState createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {

  Future getProvider() async {
    return  Provider.of<GoogleSignInProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: FutureBuilder(
        future: getProvider(),
    builder: (context, snapshot) {
    return Scaffold(
    backgroundColor: Colors.tealAccent,
    appBar: AppBar(
    title: Text('Internship App'),
    backgroundColor: Colors.teal,
    centerTitle: true,
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('I am a secret page',textAlign:TextAlign.center,style: TextStyle(fontSize:30,color: Colors.lightGreen[400]),),
    SizedBox(height: 15,),
    IconButton(icon: Icon(Icons.login_outlined,size: 20.0),onPressed: (){
    Provider.of<GoogleSignInProvider>(context,listen: false).logout().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyApp()));
    });
    },),
    ],
    ),
    ),
    );
    },
    ),
    );
  }
}

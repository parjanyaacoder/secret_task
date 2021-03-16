import 'package:flutter/material.dart';
import 'package:internship_app/SecretPage.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship App'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Login to access Secret screen',
            style: TextStyle(
              color: Colors.lightGreen[400],
            ),
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>SecretPage()));
          },
          style: ButtonStyle(
            backgroundColor:MaterialStateProperty.all<Color>(Colors.tealAccent),
          ),
        ),
      ),
    );
  }
}

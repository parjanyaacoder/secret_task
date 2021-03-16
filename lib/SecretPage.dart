import 'package:flutter/material.dart';
class SecretPage extends StatefulWidget {
  @override
  _SecretPageState createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  @override
  Widget build(BuildContext context) {
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
            IconButton(icon: Icon(Icons.login_outlined,size: 20.0),onPressed: (){},),
          ],
        ),
      ),
    );
  }
}

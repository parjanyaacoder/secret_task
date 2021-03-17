import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/SecretPage.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future getAuthentication() async {
   return   FirebaseAuth.instance.authStateChanges();
  }

  var _isInit = true;
  var _isLoading = false;
  var  provider;
  @override
  void initState() {
    provider =  Provider.of<GoogleSignInProvider>(context,listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      provider = Provider.of<GoogleSignInProvider>(context, listen: false);
      setState(() {
        _isLoading = false;
      });
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: FutureBuilder(
            future: getAuthentication(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('none');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Internship App'),
                      backgroundColor: Colors.teal,
                      centerTitle: true,
                    ),
                    body: _isLoading == true ? buildLoading() :Center(
                      child: ElevatedButton(
                        child: Text(
                          'Login to access Secret screen',
                          style: TextStyle(
                            color: Colors.lightGreen[400],
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          provider = Provider.of<GoogleSignInProvider>(
                              context, listen: false);
                          GoogleSignInProvider googleSignInProvider = new GoogleSignInProvider();
                          print("CU${googleSignInProvider.user}");
                          provider.login().then((value){
                            GoogleSignInProvider googleSignInProvider = new GoogleSignInProvider();
                            googleSignInProvider.userData = value;
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => SecretPage()),
                              ModalRoute.withName('Login')
                            );
                          });

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.tealAccent),
                        ),
                      ),
                    ),
                  );
                  break;
              }
              return null;
            }
        )
    );
  }



  Widget buildLoading() => Center(child: CircularProgressIndicator(),);

}


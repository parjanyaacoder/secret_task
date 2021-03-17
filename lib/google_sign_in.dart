import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier
{
   final googleSignIn = GoogleSignIn();
   bool _isSigningIn;
   var _user;
   GoogleSignInProvider() {
     _isSigningIn = false;
     _user = null;
   }
    get user => _user;
   bool get isSigningIn => _isSigningIn;

   set isSigningIn(bool isSigningIn) {
     _isSigningIn = isSigningIn;
     notifyListeners();
   }

   set userData(var user){
     _user = user;
     notifyListeners();
   }


   Future<String> login() async {
     isSigningIn = true;
     try {
       final user1 = await googleSignIn.signIn();
       if (user1 == null) {
         isSigningIn = false;
         return null;
       }
       else {
         final googleAuth = await user1.authentication;
         final credential = GoogleAuthProvider.credential(
           accessToken: googleAuth.accessToken,
           idToken: googleAuth.idToken,
         );
        var users =  await FirebaseAuth.instance.signInWithCredential(credential);
         userData  = users.user.uid;
         isSigningIn = false;
         return _user;

       }
     }
     catch (error)
     {
       print(error);
     }
   }

   Future logout() async {
     try {
       await googleSignIn.disconnect().then((value) async {
         await FirebaseAuth.instance.signOut().then((value) {
           userData = null;
         });
       });
     }
     catch (error)
     {
       print(error);
     }
   }

}
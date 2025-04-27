import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthenticationProvider extends ChangeNotifier{
  final _fireAuth = FirebaseAuth.instance;
  final signin = GlobalKey<FormState>();
  final signup = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  Future<void> submit() async{
    final isvalid = isLogin ? signin.currentState!.validate() : signup.currentState!.validate();

    if(!isvalid){
      return;
    }
    
    if(isLogin){
      signin.currentState!.save();
    } else {
      signup.currentState!.save();
    }

    try{
      if(isLogin){
        final UserCredential = await _fireAuth.signInWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
      } else {
        final UserCredential = await _fireAuth.createUserWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
      }
    } catch(e){
      if(e is FirebaseAuthException){
        if(e.code == "email-already-in-use"){
          print('Email sudah terdaftar');
        } else if(e.code == "user-not-found") {
          print('Email tidak terdaftar');
        } else if(e.code == "wrond-password") {
          print('Password salah');
        }
      }
    }

    notifyListeners();
  }
}
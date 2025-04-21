import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  final form = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  void submit(){
    final isvalid = form.currentState!.validate();

    if(!isvalid){
      return;
    }

    form.currentState!.save();
  }
}
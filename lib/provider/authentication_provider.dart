import 'package:economate_mobile/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final _fireAuth = FirebaseAuth.instance;
  final signin = GlobalKey<FormState>();
  final signup = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  Future<void> submit() async {
    final isvalid =
        isLogin
            ? signin.currentState!.validate()
            : signup.currentState!.validate();

    if (!isvalid) {
      return;
    }

    if (isLogin) {
      signin.currentState!.save();
    } else {
      signup.currentState!.save();
    }

    try {
      if (isLogin) {
        // Proses sign-in
        final userCredential = await _fireAuth.signInWithEmailAndPassword(
          email: enteredEmail.trim(),
          password: enteredPassword.trim(),
        );

        // Periksa apakah sign-in berhasil
        if (userCredential.user != null) {
          print('Sign-in berhasil!');
          notifyListeners();
          // Tidak perlu navigasi di sini, StreamBuilder akan menangani
        } else {
          print('Sign-in gagal!');
          // Tampilkan pesan error ke pengguna
        }
      } else {
        // Proses sign-up
        final userCredential = await _fireAuth.createUserWithEmailAndPassword(
          email: enteredEmail.trim(),
          password: enteredPassword.trim(),
        );

        // Periksa apakah sign-up berhasil
        if (userCredential.user != null) {
          print('Sign-up berhasil!');
          notifyListeners();
          // Tidak perlu navigasi di sini, StreamBuilder akan menangani
        } else {
          print('Sign-up gagal!');
          // Tampilkan pesan error ke pengguna
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('Email tidak terdaftar');
        // Tampilkan pesan error ke pengguna
      } else if (e.code == "wrong-password") {
        print('Password salah');
        // Tampilkan pesan error ke pengguna
      } else if (e.code == "email-already-in-use") {
        print('Email sudah terdaftar');
        // Tampilkan pesan error ke pengguna
      } else {
        print('Error: ${e.message}');
        // Tampilkan pesan error ke pengguna
      }
    } catch (e) {
      print('Error: $e');
      // Tampilkan pesan error ke pengguna
    }

    // try {
    //   if (isLogin) {
    //     final UserCredential = await _fireAuth.signInWithEmailAndPassword(
    //       email: enteredEmail,
    //       password: enteredPassword,
    //     );
    //   } else {
    //     final UserCredential = await _fireAuth.createUserWithEmailAndPassword(
    //       email: enteredEmail,
    //       password: enteredPassword,
    //     );
    //   }
    // } catch (e) {
    //   if (e is FirebaseAuthException) {
    //     if (e.code == "email-already-in-use") {
    //       // print('Email sudah terdaftar');
    //     } else if (e.code == "user-not-found") {
    //       // print('Email tidak terdaftar');
    //     } else if (e.code == "wrond-password") {
    //       // print('Password salah');
    //     }
    //   }
    // }

    // notifyListeners();
  }
}

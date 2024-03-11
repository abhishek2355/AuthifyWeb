import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_snackbar.dart';

class AuthRepo{

  Future<UserCredential?> signUpWithEmailAndPassword({required String email, required String password, required BuildContext context}) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if(context.mounted){
          AppSnackBar.warningPopUp(text: "The password provided is too weak.", context: context);
        }
      } else if (e.code == 'email-already-in-use') {
        if(context.mounted){
          AppSnackBar.warningPopUp(text: "The account already exists for that email.", context: context);
        }
      }
      return null;
    } catch (e) {
      if(context.mounted){
        AppSnackBar.errorPopUp(text: e.toString(), context: context);
      }
      return null;
    }
  }


  Future<UserCredential?> signInWithEmailAndPassword({required String email, required String password, required BuildContext context}) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if(context.mounted){
          AppSnackBar.errorPopUp(text: "No user found for that email.", context: context);
        }
      } else if (e.code == 'wrong-password') {
        if(context.mounted){
          AppSnackBar.errorPopUp(text: "Wrong password provided for that user.", context: context);
        }
      }
      if(context.mounted){
        AppSnackBar.errorPopUp(text: "Something went wrong.", context: context);
      }
      return null;
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_flow/Auth/login_screen.dart';
import 'package:login_flow/screens/home.dart';
import '../Repo/auth_repo.dart';
import 'package:login_flow/constant/app_strings.dart' as app_strings;

import '../utils/app_snackbar.dart';

class WAuthProvider with ChangeNotifier{
  AuthRepo repo = AuthRepo();
  bool isLoading = false;
  bool isPasswordShow = true;

  void updateIsLoading(){
    notifyListeners();
    isLoading = !isLoading;
    notifyListeners();
  }

  void updateIsPasswordShow(){
    notifyListeners();
    isPasswordShow = !isPasswordShow;
    notifyListeners();
  }

  Future<void> createUser({required String name, required String email, required String password, required BuildContext context}) async{
    UserCredential? status  = await repo.signUpWithEmailAndPassword(email: email, password: password, context: context);
    if(status != null){
      if(context.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context
  }) async{
    UserCredential? status  = await repo.signInWithEmailAndPassword(email: email, password: password, context: context);
    if(status != null){
      if(context.mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }
    }
  }

  Future sendPasswordLink({required String email, required BuildContext context}) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      if(context.mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MobileLoginScreen()), (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if(context.mounted){
        AppSnackBar.warningPopUp(text: e.toString(), context: context);
      }
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if(context.mounted){
        AppSnackBar.errorPopUp(text: app_strings.somethingWentWrong, context: context);
      }
    }
  }
}
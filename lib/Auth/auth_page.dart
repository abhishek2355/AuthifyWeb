import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_flow/Auth/login_screen.dart';
import 'package:login_flow/screens/home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
              // Show when there is no internet connection...
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              else{
                // If data already present into the database...
                if(snapshot.hasData){
                  return const HomeScreen();
                }
                else{
                  return const MobileLoginScreen();
                }
              }
            }
        )
    );
  }
}
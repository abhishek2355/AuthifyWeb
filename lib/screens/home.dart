import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_flow/Auth/login_screen.dart';
import 'package:login_flow/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<WAuthProvider>(builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: const Text(
              "Home Screen",
              style: TextStyle(height: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () async{
                    await state.signOut(context: context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MobileLoginScreen()), (route) => false);
                  },
                  icon: const Icon(
                    Icons.login_outlined,
                    size: 20,
                  ))
            ],
          ),
          body: const Center(child: Text("Welcome to home screen.")),
        );
      }),
    );
  }
}

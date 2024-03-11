import 'package:flutter/material.dart';
import 'package:login_flow/Auth/login_screen.dart';
import 'package:login_flow/Provider/auth_provider.dart';

import '../config/color.dart';
import '../config/validator.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import '../utils/buttons/flat_button.dart';
import 'package:provider/provider.dart';

import 'package:login_flow/constant/app_height.dart' as app_heights;
import 'package:login_flow/constant/app_width.dart' as app_widths;
import 'package:login_flow/constant/app_strings.dart' as app_strings;


class MobileSignUp extends StatefulWidget {
  const MobileSignUp({super.key});

  @override
  State<MobileSignUp> createState() => _MobileSignUpState();
}

class _MobileSignUpState extends State<MobileSignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Accessing MediaQuery for responsive layout
    // Calculate the height and width of the screen.
    var media = MediaQuery.of(context);
    final double screenHeight = media.size.height - media.padding.top - media.padding.bottom;
    final double screenWidth = media.size.width - media.padding.left - media.padding.right;
    final currentWidth = MediaQuery.of(context).size.width;


    return PopScope(
      canPop: false,
      child: Consumer<WAuthProvider>(
        builder: (context, state, _){
          return BlurryModalProgressHUD(
            inAsyncCall: state.isLoading,
            progressIndicator: const Center(child: CircularProgressIndicator()),
            dismissible: false,
            opacity: 0.4,
            color: WorkColors.background,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: WorkColors.background,
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal:(currentWidth < 600) ? screenWidth * app_widths.width25 : screenWidth * app_widths.width130),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // cancel icon
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.clear,
                                size: screenHeight * app_heights.height24,
                                color: WorkColors.idelIconButtonColor,
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height32),

                            Text(
                              app_strings.signUpButtonText,
                              style: TextStyle(fontSize: screenHeight * app_heights.height28, color: WorkColors.idelIconButtonColor,),
                            ),

                            Text(
                              app_strings.signUpSubHeading,
                              style: TextStyle(
                                fontSize: screenHeight * app_heights.height16,
                                color: WorkColors.idelIconButtonColor,
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height107),

                            SizedBox(
                              height: screenHeight * app_heights.height56,
                              child: TextFormField(
                                controller: nameController,
                                style: TextStyle(
                                  color: WorkColors.idelIconButtonColor,
                                  fontSize: screenHeight * app_heights.height16,
                                ),
                                decoration: InputDecoration(
                                  fillColor: WorkColors.background,
                                  hintText: app_strings.nameHintText,
                                  hintStyle: TextStyle(
                                    color: WorkColors.idelIconButtonColor,
                                    fontSize: screenHeight * app_heights.height16,
                                  ),
                                  errorStyle: TextStyle(fontSize: screenHeight * app_heights.height16),
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    size: screenHeight * app_heights.height20,
                                    color: WorkColors.idelIconButtonColor,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: WorkColors.idelIconButtonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height16),

                            SizedBox(
                              height: screenHeight * app_heights.height56,
                              child: TextFormField(
                                controller: emailController,
                                validator: AppValidator.validateEmail,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  color: WorkColors.idelIconButtonColor,
                                  fontSize: screenHeight * app_heights.height16,
                                ),
                                decoration: InputDecoration(
                                  fillColor: WorkColors.background,
                                  errorStyle: TextStyle(fontSize: screenHeight * app_heights.height16),
                                  hintText: app_strings.emailHintText,
                                  hintStyle: TextStyle(
                                    color: WorkColors.idelIconButtonColor,
                                    fontSize: screenHeight * app_heights.height16,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                    size: screenHeight * app_heights.height20,
                                    color: WorkColors.idelIconButtonColor,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: WorkColors.idelIconButtonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height16),

                            SizedBox(
                              height: screenHeight * app_heights.height56,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: state.isPasswordShow,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: AppValidator.validatePassword,
                                style: TextStyle(
                                  color: WorkColors.idelIconButtonColor,
                                  fontSize: screenHeight * app_heights.height16,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_rounded,
                                    size: screenHeight * app_heights.height20,
                                    color: WorkColors.idelIconButtonColor,
                                  ),
                                  hintText: app_strings.passwordHintText,
                                  hintStyle: TextStyle(
                                    color: WorkColors.idelIconButtonColor,
                                    fontSize: screenHeight * app_heights.height16,
                                  ),
                                  errorStyle: TextStyle(fontSize: screenHeight * app_heights.height16),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      state.isPasswordShow
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: screenHeight * app_heights.height20,
                                      color: WorkColors.idelIconButtonColor,
                                    ),
                                    onPressed: () {
                                      state.updateIsPasswordShow();
                                    },
                                  ),
                                  fillColor: WorkColors.background,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: WorkColors.idelIconButtonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height30),

                            FlatButton(
                              backgroundcolor: WorkColors.active,
                              child: Text(
                                app_strings.signUpButtonText,
                                style: TextStyle(fontSize: screenHeight * app_heights.height16),
                              ),
                              onPressed: () async {
                                state.updateIsLoading();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  await state.createUser(name: nameController.text, email: emailController.text, password: passwordController.text, context: context);
                                }
                                state.updateIsLoading();
                              },
                            ),

                            SizedBox(height: screenHeight * app_heights.height24),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                app_strings.signUpLowerText,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: screenHeight * app_heights.height14, color: WorkColors.idelIconButtonColor),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * app_heights.height107,
                            ),

                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MobileLoginScreen()));
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: app_strings.alreadyAccount,
                                        style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.idelIconButtonColor),
                                      ),
                                      TextSpan(
                                        text: app_strings.signInButtonText,
                                        style: TextStyle(
                                          color: WorkColors.swBorderActive,
                                          fontSize: screenHeight * app_heights.height16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * app_heights.height12),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}

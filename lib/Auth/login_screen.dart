import 'package:flutter/material.dart';
import 'package:login_flow/Auth/forgot_password.dart';
import 'package:login_flow/Auth/registration_scree..dart';
import 'package:provider/provider.dart';

import '../config/color.dart';
import '../config/validator.dart';
import '../utils/buttons/elevated_buttons.dart';
import '../utils/buttons/flat_button.dart';
import 'package:login_flow/Provider/auth_provider.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_flow/constant/app_height.dart' as app_heights;
import 'package:login_flow/constant/app_width.dart' as app_widths;
import 'package:login_flow/constant/app_strings.dart' as app_strings;

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  // Variable declaration.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            blurEffectIntensity: 1.0,
            progressIndicator: const Center(child: CircularProgressIndicator()),
            dismissible: false,
            opacity: 0.4,
            color: WorkColors.background,
            child: Scaffold(
              backgroundColor: WorkColors.background,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: (currentWidth < 600) ? screenWidth * app_widths.width25: screenWidth * app_widths.width130) ,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox with height 50.
                        SizedBox(height: screenHeight * app_heights.height50,),
                        //Welcome Text
                        Text(
                          app_strings.welcome,
                          style: TextStyle(fontSize: screenHeight * app_heights.height24, color: WorkColors.idelIconButtonColor),
                        ),
                        // Sub heading of login screen.
                        Text(
                          app_strings.subtext,
                          style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.idelIconButtonColor),
                        ),
                        //SizedBox with height 120.
                        SizedBox(height: screenHeight * app_heights.height120,),
                        // email text field.
                        SizedBox(
                          height: screenHeight * app_heights.height75,
                          child: TextFormField(
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: AppValidator.validateEmail,
                            style: TextStyle(
                              color: WorkColors.idelIconButtonColor,
                              fontSize: screenHeight * app_heights.height16,
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: screenHeight * app_heights.height16),
                              fillColor: WorkColors.background,
                              hintText: app_strings.emailHintText,
                              hintStyle: TextStyle(
                                color: WorkColors.idelIconButtonColor,
                                fontSize: screenHeight * app_heights.height16,
                              ),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                size: screenHeight * app_heights.height24,
                                color: WorkColors.idelIconButtonColor,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: WorkColors.idelIconButtonColor),
                              ),
                            ),
                          ),
                        ),

                        //SizedBox with height 16.
                        SizedBox(height: screenHeight * app_heights.height16),

                        // password text field.
                        SizedBox(
                          height: screenHeight * app_heights.height75,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: state.isPasswordShow,
                            validator: AppValidator.validatePassword,
                            style: TextStyle(
                              color: WorkColors.idelIconButtonColor,
                              fontSize: screenHeight * app_heights.height16,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: screenHeight * app_heights.height16),
                              prefixIcon: Icon(
                                Icons.lock_rounded, size: screenHeight * app_heights.height20,
                                color: WorkColors.idelIconButtonColor,
                              ),
                              hintText: app_strings.passwordHintText,
                              hintStyle: TextStyle(
                                color: WorkColors.idelIconButtonColor,
                                fontSize: screenHeight * app_heights.height16,
                              ),
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
                                borderSide:
                                BorderSide(color: WorkColors.idelIconButtonColor),
                              ),
                            ),
                          ),
                        ),

                        // SizedBox with height 24.
                        SizedBox(height: screenHeight * app_heights.height24,),

                        // Forgot text.
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPaswordScreen()));},
                            child: Text(
                              app_strings.forgotPasswordText,
                              style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.active),
                            ),
                          ),
                        ),

                        // SizedBox with height 50.
                        SizedBox(height: screenHeight * app_heights.height50,),

                        // Sign in button.
                        FlatButton(
                          backgroundcolor: WorkColors.active,
                          child: Text(
                            app_strings.signInButtonText,
                            style: TextStyle(fontSize: screenHeight * app_heights.height16),
                          ),
                          onPressed: () async {
                            state.updateIsLoading();
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await state.loginUser(email: emailController.text, password: passwordController.text, context: context);
                            }
                            state.updateIsLoading();
                          },
                        ),

                        // SizedBox with height 24.
                        SizedBox(height: screenHeight * app_heights.height24,),

                        // OR
                        Row(
                          children: <Widget>[
                            const Expanded(
                              child: Divider(color: WorkColors.idelIconButtonColor,),
                            ),
                            Text(
                              app_strings.orText,
                              style: TextStyle(fontSize: screenHeight * app_heights.height14, color: WorkColors.idelIconButtonColor),
                            ),
                            const Expanded(child: Divider(color: WorkColors.idelIconButtonColor),),
                          ],
                        ),

                        // SizedBox with height 24.
                        SizedBox(height: screenHeight * app_heights.height24,),

                        // Apple Login.
                        ElevatedButtons(
                          onPressed: () {},
                          backgroundcolor: WorkColors.inActive,
                          child: Row(
                            children: [
                              Icon(Icons.apple, size: screenHeight * app_heights.height24, color: WorkColors.idelIconButtonColor,),

                              SizedBox(width: screenWidth * app_widths.width30,),

                              Text(
                                app_strings.appleLoginText,
                                style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.idelIconButtonColor),
                              )
                            ],
                          ),
                        ),

                        // SizedBox with height 16.
                        SizedBox(height: screenHeight * app_heights.height16,),

                        // Google Login.
                        ElevatedButtons(
                          onPressed: () {},
                          backgroundcolor: WorkColors.inActive,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                app_strings.googleLoginIcons,
                                height: screenHeight * app_heights.height24,
                                width: screenWidth * app_widths.width25,
                              ),

                              SizedBox(width: screenWidth * app_widths.width30),

                              Text(
                                app_strings.googleLoginText,
                                style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.idelIconButtonColor),
                              )
                            ],
                          ),
                        ),

                        // SizedBox with height 75.
                        SizedBox(height: screenHeight * app_heights.height75),

                        // If no account.
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MobileSignUp(),));
                          },
                          child: Align(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: app_strings.notAccount,
                                    style: TextStyle(fontSize: screenHeight * app_heights.height16, color: WorkColors.idelIconButtonColor),
                                  ),
                                  TextSpan(
                                    text: app_strings.signUpButtonText,
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

                        // SizedBox with height 12
                        SizedBox(height: screenHeight * app_heights.height12),
                      ],
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

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


class ForgotPaswordScreen extends StatefulWidget {
  const ForgotPaswordScreen({super.key});

  @override
  State<ForgotPaswordScreen> createState() => _ForgotPaswordScreenState();
}

class _ForgotPaswordScreenState extends State<ForgotPaswordScreen> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                                app_strings.forgotPasswordHeading,
                                style: TextStyle(
                                  fontSize: screenHeight * app_heights.height25,
                                  color: WorkColors.idelIconButtonColor,
                                ),
                              ),

                              SizedBox(height: screenHeight * app_heights.height107),

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

                              SizedBox(height: screenHeight * app_heights.height30),

                              FlatButton(
                                backgroundcolor: WorkColors.active,
                                child: Text(
                                  app_strings.send,
                                  style: TextStyle(fontSize: screenHeight * app_heights.height16),
                                ),
                                onPressed: () async {
                                  state.updateIsLoading();
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await state.sendPasswordLink(email: emailController.text, context: context);
                                  }
                                  state.updateIsLoading();
                                },
                              ),
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

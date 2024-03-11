import 'package:flutter/material.dart';

import '../../config/color.dart';
import 'package:login_flow/constant/app_height.dart' as app_heights;

class FlatButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final bool enable;
  final Color? backgroundcolor;
  const FlatButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.enable = true,
    required this.backgroundcolor,
  });

  @override
  Widget build(BuildContext context) {
    // Accessing MediaQuery for responsive layout
    // Calculate the height and width of the screen.
    var media = MediaQuery.of(context);
    final double screenHeight = media.size.height - media.padding.top - media.padding.bottom;


    return SizedBox(
      width: double.infinity,
      height: screenHeight * app_heights.height56,
      child: FilledButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(
                color: WorkColors.idelIconButtonColor,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundcolor),
        ),
        key: key,
        onPressed: enable ? onPressed : null,
        child: child,
      ),
    );
  }
}

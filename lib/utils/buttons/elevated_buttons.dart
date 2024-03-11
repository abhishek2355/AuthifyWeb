import 'package:flutter/material.dart';
import 'package:login_flow/constant/app_height.dart' as app_heights;

class ElevatedButtons extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final bool enable;
  final Color? backgroundcolor;
  const ElevatedButtons({
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
      child: SizedBox(
        height: screenHeight * app_heights.height56,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            backgroundColor: MaterialStateProperty.all(backgroundcolor),),
          key: key,
          onPressed: enable
              ? onPressed
              : null,
          child: child,
        ),
      ),
    );
  }
}

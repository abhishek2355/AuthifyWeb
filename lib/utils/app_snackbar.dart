import 'package:flutter/cupertino.dart';

import '../../config/color.dart';
import 'package:quickalert/quickalert.dart';

class AppSnackBar {
  // Success SnackBar
  static successPopUp({required String text, required BuildContext context}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: text,
      autoCloseDuration: const Duration(seconds: 5),
      showConfirmBtn: false,
    );
  }

  // Error SnackBar
  static errorPopUp({
    required String? text,
    required BuildContext context
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: text ?? 'Something went wrong!',
      backgroundColor: WorkColors.backgroundLite,
      autoCloseDuration: const Duration(seconds: 5),
      titleColor: WorkColors.background,
      textColor: WorkColors.background,
    );
  }

  // Warning SnackBar
  static warningPopUp({required String text, required BuildContext context}) {
    QuickAlert.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 5),
      type: QuickAlertType.warning,
      text: text,
    );
  }
}

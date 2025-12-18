import 'package:get/get.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/global_variables.dart';

void stopLoaderAndShowSnackBar({String message = '', bool success = true, bool goBack = false}) {
  GlobalVariables.showLoader.value = false;
  if(goBack) Get.back();
  showSnackBar(message: message, success: success);
}

void showSnackBar({required String message, required bool success}) {

  String title = '';

  if(success) {
    title = lang_key.success.tr;
  } else {
    title = lang_key.error.tr;
  }

  Get.snackbar(
    title,
    message,
    colorText: primaryWhite,
    snackPosition: SnackPosition.TOP,
    backgroundColor: success == true ? Colors.lightGreen : errorRed,
    isDismissible: false,
    animationDuration: Duration(milliseconds: 800),
  );
}
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helpers/stop_loader_and_show_snackbar.dart';
import '../../../models/admin.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_paths.dart';

class LoginViewModel extends GetxController {

  /// Controller(s) & Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Observable variable for obscuring password
  RxBool obscurePassword = true.obs;

  /// Observable variable for checkbox
  RxBool checkBoxValue = false.obs;

  @override
  void onReady() async {
    final Map<String, dynamic>? args = Get.arguments;

    if(args == null) {
      GlobalVariables.token = GlobalVariables.prefs?.getString(tokenKey) ?? '';
      if(GlobalVariables.token.isNotEmpty) {
        _getUserProfile();
      }
    }
    super.onReady();
  }

  /// API call to login
  void login() {
    if(formKey.currentState!.validate()){
      GlobalVariables.showLoader.value = true;

      ApiBaseHelper.postMethod(
          url: Urls.login,
          withAuthorization: false,
          redirectToLogin: false,
          body: {
            'email': emailController.text.trim(),
            'password': passwordController.text.trim(),
          }).then((value) async {

            if(value.success!) {

              await GlobalVariables.prefs?.setString(tokenKey, value.data['token']);
              GlobalVariables.token = value.data['token'];

              final fetchLogoUrl = ApiBaseHelper.getMethod(url: Urls.brandLogo);
              final fetchMessagesCount = ApiBaseHelper.getMethod(url: Urls.fetchUnreadMessagesCount);

              final responses = await Future.wait([fetchLogoUrl, fetchMessagesCount]);

              if(responses[0].success == true && responses[0].data != null) {
                GlobalVariables.logoUrl.value = responses[0].data['logo_url'];
              }

              if(responses[1].success == true && responses[1].data != null) {
                GlobalVariables.unreadMessagesCount.value = responses[1].data['count'];
              }

              GlobalVariables.showLoader.value = false;

              Get.offAllNamed(Routes.homeBanner);
            } else {
              stopLoaderAndShowSnackBar(success: false, message: value.message!);
            }
          });
    }
  }

  void _getUserProfile() {
    ApiBaseHelper.getMethod(
        url: Urls.getUserProfile,
    ).then((value) {
      if(value.success!) {
        GlobalVariables.showLoader.value = false;
        GlobalVariables.userDetails.value = Admin.fromJson(value.data['user']);
        Get.offAllNamed(Routes.homeBanner);
      } else {
        stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);
      }
    });

  }
}
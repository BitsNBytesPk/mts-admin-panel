import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../helpers/stop_loader_and_show_snackbar.dart';
import '../languages/translation_keys.dart' as lang_key;

class InitBinding extends Bindings {

  @override
  void dependencies() async {
    if(GlobalVariables.token != '') {

      GlobalVariables.showLoader.value = true;

      final fetchLogoUrl = ApiBaseHelper.getMethod(url: Urls.brandLogo);
      final fetchMessagesCount = ApiBaseHelper.getMethod(url: Urls.fetchUnreadMessagesCount);

      final responses = await Future.wait([fetchLogoUrl, fetchMessagesCount]);

      if(responses[0].success == true && responses[0].data != null) {
        GlobalVariables.logoUrl.value = responses[0].data['logo_url'];
      }

      if(responses[1].success == true && responses[1].data != null) {
        GlobalVariables.unreadMessagesCount.value = responses[1].data['count'];
      }
      
      if(responses.isEmpty || responses.every((element) => !element.success!)) {
        showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
      }

      GlobalVariables.showLoader.value = false;
    }
  }
}
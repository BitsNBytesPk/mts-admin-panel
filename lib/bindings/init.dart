import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

class InitBinding extends Bindings {

  @override
  void dependencies() {
    if(GlobalVariables.token != '') {
      ApiBaseHelper.getMethod(url: Urls.brandLogo).then((value) {
        if(value.success!) {
          GlobalVariables.logoUrl.value = value.data['logo_url'];
        }
      });
    }
  }
}
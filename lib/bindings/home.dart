import 'package:get/get.dart';

import '../utils/api_base_helper.dart';
import '../utils/global_variables.dart';
import '../utils/url_paths.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    ApiBaseHelper.getMethod(url: Urls.brandLogo).then((value) {
      if(value.success!) {
        GlobalVariables.logoUrl = value.data['logo_url'];
      }
    });
  }
}
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

class HomeProjectPreviewViewModel extends GetxController {

  Rx<Cards> homeProjectCard = Cards().obs;

  @override
  void onReady() {
    final Map<String, dynamic>? args = Get.arguments;
    if(args != null && args.containsKey('projectCard')) {
      homeProjectCard.value = Cards.fromJson(args['projectCard']);
    } else {
      Get.offAllNamed(Routes.homeProjects);
    }
    super.onReady();
  }
}
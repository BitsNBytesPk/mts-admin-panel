import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

class HomeProjectPreviewViewModel extends GetxController {

  Rx<HomeInnovationCards> homeProjectCard = HomeInnovationCards().obs;

  @override
  void onReady() {
    final Map<String, dynamic>? args = Get.arguments;
    if(args != null && args.containsKey('projectData')) {
      homeProjectCard.value = HomeInnovationCards.fromJson(args['projectData']);
    } else {
      Get.offAllNamed(Routes.homeProjects);
    }
    super.onReady();
  }
}
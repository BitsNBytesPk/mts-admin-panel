import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/responsibility_data.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

class ResponsibilityProjectPreviewViewModel extends GetxController {

  Rx<ResponsibilityDeploymentCards> responsibilityProjectCard = ResponsibilityDeploymentCards().obs;

  @override
  void onReady() {
    final Map<String, dynamic>? args = Get.arguments;
    if(args != null && args.containsKey('projectData')) {
      responsibilityProjectCard.value = ResponsibilityDeploymentCards.fromJson(args['projectData']);
    } else {
      Get.offAllNamed(Routes.responsibilityProjects);
    }
    super.onReady();
  }
}
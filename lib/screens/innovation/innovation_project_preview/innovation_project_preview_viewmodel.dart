import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/innovation_data.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

class InnovationProjectPreviewViewModel extends GetxController {

  Rx<InnovationProjects> project = InnovationProjects().obs;

  @override
  void onReady() {
    final Map<String, dynamic>? args = Get.arguments;

    if(args != null && args.containsKey('projectData')){
      project.value = args['projectData'];
    } else if(args == null) {
      Get.offAllNamed(Routes.innovationContent);
    }
    super.onReady();
  }

}
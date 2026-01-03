import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

import '../../../models/responsibility_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class ResponsibilityContentViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();
  RxList<TextEditingController> ourCommitmentControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> collaborationControllers = <TextEditingController>[].obs;
  RxList<TextEditingController> impactDashboardControllers = <TextEditingController>[].obs;

  GlobalKey<FormState> ourCommitmentFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> collaborationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> impactDashboardFormKey = GlobalKey<FormState>();

  /// Height Variables for SectionContainers
  RxnDouble ourCommitmentHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble collaborationHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble impactDashboardHeight = RxnDouble(kSectionContainerHeightValue);

  /// Responsibility Page Data
  Rx<ResponsibilityData> responsibilityData = ResponsibilityData().obs;

  @override
  void onReady() {
    _fetchResponsibilityData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void _fetchResponsibilityData() {

    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.responsibilityData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        responsibilityData.value = ResponsibilityData.fromJson(value.data);
        _fillOurCommitmentStatControllers();
        _fillCollaborationStatControllers();
        _fillImpactDashboardStatControllers();
      }
    });
  }

  void _fillOurCommitmentStatControllers() {
    responsibilityData.value.content?.commitment?.stats?.forEach((element) {
      ourCommitmentControllers.add(TextEditingController(text: element.value));

      if(element == responsibilityData.value.content?.commitment?.stats?.last) {
        ourCommitmentControllers.refresh();
      }
    });
  }

  void _fillCollaborationStatControllers() {
    responsibilityData.value.content?.partnerships?.cards?.forEach((element) {
      collaborationControllers.add(TextEditingController(text: element.count));

      if(element == responsibilityData.value.content?.partnerships?.cards?.last) {
        collaborationControllers.refresh();
      }
    });
  }

  void _fillImpactDashboardStatControllers() {
    responsibilityData.value.content?.impact?.metrics?.forEach((element) {
      impactDashboardControllers.add(TextEditingController(text: element.value));

      if(element == responsibilityData.value.content?.impact?.metrics?.last) {
        impactDashboardControllers.refresh();
      }
    });
  }
}
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../models/responsibility_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class ResponsibilityProjectsListingViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController projectTitleController = TextEditingController();
  TextEditingController projectSubtitleController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();
  Map<TextEditingController, TextEditingController> projectStats = <TextEditingController, TextEditingController>{
    TextEditingController(): TextEditingController(),
    TextEditingController(): TextEditingController(),
  };
  GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();

  /// Height Variables for SectionContainers
  RxnDouble projectFormHeight = RxnDouble(kSectionContainerHeightValue);

  /// Form Variables
  Rx<Uint8List> projectImage = Uint8List(0).obs;

  /// Projects List
  RxList<ResponsibilityDeploymentCards> projects = <ResponsibilityDeploymentCards>[].obs;

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
        projects.addAll(responsibilityData.value.content?.deployments?.cards ?? []);
        projects.refresh();
      }
    });
  }
}
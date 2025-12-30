import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import '../../../models/innovation_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class InnovationContentViewModel extends GetxController {

  ScrollController scrollController = ScrollController();

  TextEditingController projectMainTitleController = TextEditingController();
  TextEditingController projectSubtitleController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController firstHeadingController = TextEditingController();
  TextEditingController secondHeadingController = TextEditingController();
  TextEditingController thirdHeadingController = TextEditingController();

  TextEditingController firstInformaticsSubtitleController = TextEditingController();
  TextEditingController secondInformaticsSubtitleController = TextEditingController();
  TextEditingController thirdInformaticsSubtitleController = TextEditingController();

  RxMap<TextEditingController, TextEditingController> technologySection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;
  RxMap<TextEditingController, TextEditingController> applicationSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;
  RxMap<TextEditingController, TextEditingController> statisticsSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;

  RxList<Projects> projects = <Projects>[].obs;

  Rx<InnovationData> innovationData = InnovationData().obs;

  RxnDouble projectsHeight = RxnDouble(kSectionHeightValue);

  /// Project Details related variables
  Rx<Uint8List> projectImage = Uint8List(0).obs;
  RxBool includeInHome = false.obs;

  @override
  void onReady() {
    _fetchInnovationData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    projectMainTitleController.dispose();
    projectSubtitleController.dispose();
    projectDescController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _fetchInnovationData() {

    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.innovationData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        innovationData.value = InnovationData.fromJson(value.data);
        _populateLists();
      }
    });
  }

  void _populateLists() async {
    projects.addAll(innovationData.value.content?.projects ?? []);
    projects.refresh();
  }
}
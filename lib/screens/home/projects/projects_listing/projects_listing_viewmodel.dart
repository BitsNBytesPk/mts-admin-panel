import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

class HomeProjectsListingViewmodel extends GetxController {

  /// Controller(s) & Global Key
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController projectMainTitleController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();

  /// Form Variables
  RxnDouble projectFormHeight = RxnDouble(kSectionContainerHeightValue);
  Rx<Uint8List> projectIcon = Uint8List(0).obs;
  RxMap<TextEditingController, TextEditingController> statisticsSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;

  /// Projects List for Home Page
  RxList<HomeInnovationCards> projects = <HomeInnovationCards>[].obs;

  @override
  void onReady() {
    fetchProjectsData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    projectMainTitleController.dispose();
    projectDescriptionController.dispose();
    super.onClose();
  }

  void fetchProjectsData() {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.homeData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        final homeData = HomeData.fromJson(value.data);
        projects.addAll(homeData.content?.innovations?.cards ?? []);
        projects.refresh();
      } else {
        showSnackBar(message: value.message!, success: false);
      }
    });
  }
}
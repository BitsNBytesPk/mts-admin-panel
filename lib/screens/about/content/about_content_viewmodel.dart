import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/shared_data.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../helpers/stop_loader_and_show_snackbar.dart';
import '../../../languages/translation_keys.dart' as lang_key;
import '../../../models/about_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class AboutContentViewModel extends GetxController {

  /// Controller(s) & Global Key
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();

  TextEditingController milestoneDescController = TextEditingController();
  TextEditingController milestoneTitleController = TextEditingController();
  TextEditingController milestoneYearTextController = TextEditingController();

  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> milestoneDetailsFormKey = GlobalKey<FormState>();

  RxnDouble personalDetailsHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble milestonesAndAchievementsHeight = RxnDouble(kSectionContainerHeightValue);

  Rx<AboutData> aboutData = AboutData().obs;
  Rx<SharedData> sharedData = SharedData().obs;

  Rx<Uint8List> newImage = Uint8List(0).obs;

  RxList<AchievementsItems> milestonesAndAchievementsList = <AchievementsItems>[].obs;

  RxBool updatingValue = false.obs;

  @override
  void onReady() {
    fetchAboutData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void fetchAboutData() async {

    GlobalVariables.showLoader.value = true;

    final aboutContent = ApiBaseHelper.getMethod(url: Urls.aboutData);
    final personalDetails = ApiBaseHelper.getMethod(url: Urls.sharedData);

    final responses = await Future.wait([aboutContent, personalDetails]);

    if(responses[0].success == true && responses[1].data != null) {
      aboutData.value = AboutData.fromJson(responses[0].data);
      milestonesAndAchievementsList.addAll(aboutData.value.content?.timelineItems ?? []);
      milestonesAndAchievementsList.refresh();
    }

    if(responses[1].success == true && responses[1].data != null) {
      sharedData.value = SharedData.fromJson(responses[1].data);
      _fillAboutPersonalDetailsControllers();
    }

    if(responses.isEmpty || responses.every((element) => !element.success!)) {
      showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
    }

    GlobalVariables.showLoader.value = false;
  }

  void _fillAboutPersonalDetailsControllers() {
    nameController.text = sharedData.value.content?.leadership?.people?.first.name ?? '';
    designationController.text = sharedData.value.content?.leadership?.people?.first.role ?? '';
    pageBannerDescriptionController.text = sharedData.value.content?.leadership?.people?.first.bio ?? '';
  }

  void fillMilestoneControllers(int index) {
    milestoneTitleController.text = milestonesAndAchievementsList[index].title ?? '';
    milestoneYearTextController.text = milestonesAndAchievementsList[index].year ?? '';
    milestoneDescController.text = milestonesAndAchievementsList[index].description ?? '';
  }
}
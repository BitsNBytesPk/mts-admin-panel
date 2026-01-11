import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/show_confirmation_dialog.dart';
import 'package:mts_website_admin_panel/models/shared_data.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController personalDetailsDescriptionController = TextEditingController();

  TextEditingController milestoneDescController = TextEditingController();
  TextEditingController milestoneTitleController = TextEditingController();
  TextEditingController milestoneYearTextController = TextEditingController();

  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> milestoneDetailsFormKey = GlobalKey<FormState>();

  RxnDouble personalDetailsHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble milestonesAndAchievementsHeight = RxnDouble(kSectionContainerHeightValue);

  Rx<AboutData> aboutData = AboutData().obs;
  Rx<People> leadershipData = People().obs;

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
      final SharedData sharedData = SharedData.fromJson(responses[1].data);

      if(sharedData.content != null && sharedData.content!.leadership != null && sharedData.content!.leadership!.people != null && sharedData.content!.leadership!.people!.isNotEmpty) {
        leadershipData.value = sharedData.content!.leadership!.people!.first;
        _fillAboutPersonalDetailsControllers();
      }

    }

    if(responses.isEmpty || responses.every((element) => !element.success!)) {
      showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
    }

    GlobalVariables.showLoader.value = false;
  }

  void _fillAboutPersonalDetailsControllers() {
    nameController.text = leadershipData.value.name ?? '';
    designationController.text = leadershipData.value.role ?? '';
    personalDetailsDescriptionController.text = leadershipData.value.bio ?? '';
  }

  void fillMilestoneControllers(int index) {
    milestoneTitleController.text = milestonesAndAchievementsList[index].title ?? '';
    milestoneYearTextController.text = milestonesAndAchievementsList[index].year ?? '';
    milestoneDescController.text = milestonesAndAchievementsList[index].description ?? '';
  }

  void updatePersonalData() {

    if(personalDetailsFormKey.currentState!.validate()) {

      Map<String, dynamic> body = {};
      List<http.MultipartFile> files = [];

      body.addIf(nameController.text != leadershipData.value.name, 'name', nameController.text);
      body.addIf(designationController.text != leadershipData.value.role, 'role', designationController.text);
      body.addIf(personalDetailsDescriptionController.text != leadershipData.value.bio, 'bio', personalDetailsDescriptionController.text);
      
      if(newImage.value.isNotEmpty) {
        files.add(http.MultipartFile.fromBytes('image', newImage.value));
      }
      
      if(body.isEmpty && files.isEmpty) {
        showSnackBar(message: 'No changes made', success: false);
      } else {

        body.addAll({'page': 'shared', 'index': 0});

        GlobalVariables.showLoader.value = true;

        ApiBaseHelper.patchMethodForImage(
            url: Urls.personalDetails,
            files: files,
            fields: body
        ).then((value) {
          stopLoaderAndShowSnackBar(message: value.success! ? 'Data updated successfully' : value.message!, success: value.success!);

          if(value.success! && value.data['updated_person'] != null) {
            leadershipData.value = People.fromJson(value.data['updated_person']);
            leadershipData.refresh();
            _fillAboutPersonalDetailsControllers();

            if(newImage.value.isNotEmpty) {
              newImage.value = Uint8List(0);
            }
          }
        });
      }
    }
  }

  void milestoneDeletionConfirmation(int index) {
    showConfirmationDialog(
      title: 'Delete Entry',
        message: 'Are you sure, you want to delete this entry? This action cannot be reversed.',
        onPressed: () {

          final tempList = milestonesAndAchievementsList;
          tempList.removeAt(index);

          Get.back();

          GlobalVariables.showLoader.value = true;

          ApiBaseHelper.patchMethod(
              url: Urls.aboutData,
              body: {
                'content': {
                  'timeline': {
                    'items': tempList.map((e) => e.toJson()).toList()
                  }
                }
              }
          ).then((value) {
            stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

            if(value.success!) {
              milestonesAndAchievementsList.clear();

              aboutData.value = AboutData.fromJson(value.data['page']);

              milestonesAndAchievementsList.addAll(aboutData.value.content?.timelineItems ?? []);
              milestonesAndAchievementsList.refresh();
            }
          });
      });
  }

  void addNewMilestoneEntry() {
    if(milestoneDetailsFormKey.currentState!.validate()) {

      final tempList = milestonesAndAchievementsList;

      tempList.add(AchievementsItems(title: milestoneTitleController.text, description: milestoneDescController.text, year: milestoneYearTextController.text));

      GlobalVariables.showLoader.value = true;

      ApiBaseHelper.patchMethod(
        url: Urls.aboutData,
        body: {
          'content': {
            'timeline': {
              'items': tempList.map((e) => e.toJson()).toList()
            }
          }
        }
      ).then((value) {
        stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

        if(value.success!) {
          aboutData.value = AboutData.fromJson(value.data);
          milestonesAndAchievementsList.addAll(aboutData.value.content?.timelineItems ?? []);
          milestonesAndAchievementsList.refresh();

          milestoneYearTextController.clear();
          milestoneDescController.clear();
          milestoneTitleController.clear();
        }
      });
    }
  }

}
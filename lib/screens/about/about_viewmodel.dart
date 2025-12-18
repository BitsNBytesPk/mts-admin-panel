import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/populate_lists.dart';
import 'package:mts_website_admin_panel/models/project.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;

import '../../helpers/scroll_controller_funcs.dart';
import '../../helpers/stop_loader_and_show_snackbar.dart';

class AboutViewModel extends GetxController {

  /// Controller(s) & Global Key(s)
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();
  TextEditingController projectSearchController = TextEditingController();
  TextEditingController projectIosLinkController = TextEditingController();
  TextEditingController projectAndroidLinkController = TextEditingController();
  TextEditingController projectGithubLinkController = TextEditingController();
  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  Rx<Color> projectColor = Color(0xff0088ff).obs;

  /// Variable for page toggling
  RxInt currentPage = 0.obs;
  RxInt totalPages = 3.obs;

  /// Limit variables
  int limit = 30;

  /// Zones list data
  RxList<Project> allProjectsList = <Project>[].obs;
  RxList<Project> visibleProjectsList = <Project>[].obs;

  RxList<String> keyFeatures = <String>[].obs;
  RxList<String> techStack = <String>[].obs;

  /// Variable to toggle auto-validation of form fields.
  RxBool enableAutoValidation = true.obs;

  RxString projectStatus = lang_key.underDevelopment.tr.obs;
  RxString projectType = 'Mobile'.obs;

  Rx<Uint8List> projectImage = Uint8List(0).obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    getAllProjects();
    super.onReady();  
  }

  @override
  void onClose() {
    projectNameController.dispose();
    projectDescController.dispose();
    projectSearchController.dispose();
    projectIosLinkController.dispose();
    projectAndroidLinkController.dispose();
    projectGithubLinkController.dispose();
    keyFeatures.clear();
    techStack.clear();
    scrollController.dispose();
    super.onClose();
  }

  /// Add new zone API call.
  void addNewProject() {
    if(projectFormKey.currentState!.validate()) {
      enableAutoValidation.value = false;
      if(projectImage.value.isEmpty || projectImage.value == Uint8List(0)) {
        showSnackBar(message: 'Add Project Logo/Image', success: false);
      } else {

        GlobalVariables.showLoader.value = true;

        ApiBaseHelper.postMethod(
            url: Urls.addNewProject,
            body: {
              'name': projectNameController.text,
              'description': projectDescController.text,
              // 'image': projectImage.value,
              'ios_link': projectIosLinkController.text,
              'android_link': projectAndroidLinkController.text,
              'github_link': projectGithubLinkController.text,
              'project_color': projectColor.value.toString(),
              'project_status': projectStatus.value,
              'tech_stack': techStack,
              'key_features': keyFeatures,
            }
        ).then((value) {
          stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);
          
          if(value.success!) {
            clearControllersAndVariables();
            
            allProjectsList.add(Project.fromJson(value.data));
            visibleProjectsList.clear();
            visibleProjectsList.addAll(allProjectsList);
          }
        });
      }
    } else {
      enableAutoValidation.value = true;
    }
  }

  /// Get zones list API call.
  void getAllProjects() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper.getMethod(
        url: "${Urls.getAllProjects}?limit=$limit&page=${currentPage.value}",
    ).then((value) {

      GlobalVariables.showLoader.value = false;

      if(value.success!) populateLists(allProjectsList, value.data, visibleProjectsList, (dynamic json) => Project.fromJson(json));
    });
  }

  /// Change zone status to active or in-active.
  void changeProjectStatus(String id) {
    GlobalVariables.showLoader.value = true;

    final projectDetails = visibleProjectsList.firstWhere((element) => element.id == id);

    ApiBaseHelper.patchMethod(
      body: {
        'status': !projectDetails.status!
      },
        url: Urls.editProject(id)
    ).then((value) {
      stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);
      if(value.success!) {
        final allProjectListIndex = allProjectsList.indexWhere((element) => element.id! == id);
        if(allProjectListIndex >= 0) {
          allProjectsList[allProjectListIndex].status = !allProjectsList[allProjectListIndex].status!;
        }
        addDataToVisibleList(allProjectsList, visibleProjectsList);
      }
    });
  }

  /// Delete an existing zone
  void deleteProject(int index) {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.deleteMethod(
        url: Urls.deleteProject(visibleProjectsList[index].id.toString())
    ).then((value) {
      stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

      if(value.success!) {
        allProjectsList.removeWhere((element) => element.id == visibleProjectsList[index].id);
        allProjectsList.refresh();
        addDataToVisibleList(allProjectsList, visibleProjectsList);
      }

    });
  }

  /// Clear controllers and variables associated with adding a new zone
  void clearControllersAndVariables() {
    enableAutoValidation.value = false;
    projectNameController.clear();
    projectDescController.clear();
    projectGithubLinkController.clear();
    projectAndroidLinkController.clear();
    projectIosLinkController.clear();
    keyFeatures.clear();
    techStack.clear();
    projectStatus.value = lang_key.underDevelopment.tr;
    projectColor.value = Color(0xff0088ff);
    projectImage.value = Uint8List(0);
  }

  /// Search zone and update visible list.
  void searchInList(String? value) {
    if(value == '' || value == null || value.isEmpty) {
      addDataToVisibleList(allProjectsList, visibleProjectsList);
    } else {
      addDataToVisibleList(allProjectsList.where((element) => element.name!.toLowerCase().trim().contains(value.toLowerCase().trim())).toList(), visibleProjectsList);
    }
  }
}
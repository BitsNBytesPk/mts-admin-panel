import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/show_confirmation_dialog.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import '../../../models/innovation_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_paths.dart';

class InnovationContentViewModel extends GetxController {

  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController projectMainTitleController = TextEditingController();
  TextEditingController projectSubtitleController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();

  TextEditingController technologySectionHeadingController = TextEditingController();
  TextEditingController applicationSectionHeadingController = TextEditingController();

  RxMap<TextEditingController, TextEditingController> informaticsSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;
  RxMap<TextEditingController, TextEditingController> technologySection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;
  RxMap<TextEditingController, TextEditingController> applicationSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;
  RxMap<TextEditingController, TextEditingController> statisticsSection = <TextEditingController, TextEditingController>{TextEditingController(): TextEditingController()}.obs;

  RxList<InnovationProjects> projects = <InnovationProjects>[].obs;

  Rx<InnovationData> innovationData = InnovationData().obs;

  RxnDouble projectsHeight = RxnDouble(kSectionContainerHeightValue);

  /// Project Details related variables
  Rx<Uint8List> projectImage = Uint8List(0).obs;

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
  
  void addProject() async {
    
    if(formKey.currentState!.validate()) {
      
      if(projectImage.value.isEmpty) {
        showSnackBar(message: 'Add image to proceed', success: false);
      } else {

        GlobalVariables.showLoader.value = true;

        List<Items> applicationItem = [];
        List<Items> technologyItem = [];
        List<Metrics> metrics = [];

        applicationSection.forEach((key, value) => applicationItem.add(Items(title: key.text, description: value.text)));
        technologySection.forEach((key, value) => technologyItem.add(Items(title: key.text, description: value.text)));
        informaticsSection.forEach((key, value) => metrics.add(Metrics(label: key.text, value: value.text)));

        List<http.MultipartFile> file = [];

        if(projectImage.value.isNotEmpty) {
          file.add(http.MultipartFile.fromBytes('image', projectImage.value));
        }

        ApiBaseHelper.postMethodForImage(
            url: Urls.innovationProject,
            fields: {
              'page': 'innovation',
              'title': projectMainTitleController.text,
              'category': projectSubtitleController.text,
              'description': projectDescController.text,
              // 'image': projectImage.value,
              'metrics': jsonEncode(metrics.map((e) => e.toJson()).toList()),
              'application': applicationItem.map((e) => e.toJson()).toList(),
              'technology': technologyItem.map((e) => e.toJson()).toList(),
              'technology_heading': technologySectionHeadingController.text,
              'application_heading': applicationSectionHeadingController.text,
              'technology_label': 'Technology',
              'application_label': 'Applications',
            },
            files: file
        ).then((value) {

          stopLoaderAndShowSnackBar(success: value.success!, message: value.message!);

          if(value.success!) {
            projects.add(InnovationProjects.fromJson(value.data['updated_project']));
            projects.refresh();
            projectMainTitleController.clear();
            projectSubtitleController.clear();
            projectDescController.clear();
            technologySectionHeadingController.clear();
            applicationSectionHeadingController.clear();

            for(int i = 0; i <= technologySection.length - 1 ; i++) {
              if(i == 0) {
                technologySection.keys.first.clear();
                technologySection.values.first.clear();
              } else {
                technologySection.keys.elementAt(i).dispose();
                technologySection.values.elementAt(i).dispose();

                technologySection.remove(technologySection.keys.elementAt(i));
                // technologySection.values.elementAt(i).clear();

              }
            }

            for(int i = 0; i <= applicationSection.length - 1 ; i++) {
              if(i == 0) {
                applicationSection.keys.first.clear();
                applicationSection.values.first.clear();
              } else {
                applicationSection.keys.elementAt(i).dispose();
                applicationSection.values.elementAt(i).dispose();

                applicationSection.remove(applicationSection.keys.elementAt(i));

              }
            }

            for(int i = 0; i <= informaticsSection.length - 1 ; i++) {
              if(i == 0) {
                informaticsSection.keys.first.clear();
                informaticsSection.values.first.clear();
              } else {
                informaticsSection.keys.elementAt(i).dispose();
                informaticsSection.values.elementAt(i).dispose();

                informaticsSection.remove(informaticsSection.keys.elementAt(i));
                // technologySection.values.elementAt(i).clear();

              }
            }

          }

        });
      }
    }
  }

  void deleteProject(int index) {
    
    showConfirmationDialog(
        message: 'Are you sure you want to delete this project?',
        title: 'Delete Project',
        onPressed: () {
          Get.back();

          GlobalVariables.showLoader.value = true;
          
          ApiBaseHelper.deleteMethod(
            url: Urls.innovationProject,
            body: {
              "page": "innovation",
              "index": "$index"
            }
          ).then((value) {

            stopLoaderAndShowSnackBar(success: value.success!, message: value.message!);

            if(value.success!) {
              projects.removeAt(index);
              projects.refresh();
            }

          });
        }
    );
  }
  
  void navigateToPreviewScreen() {
    if(formKey.currentState!.validate()) {

      List<Items> applicationItem = [];
      List<Items> technologyItem = [];
      List<Metrics> metrics = [];

      applicationSection.forEach((key, value) => applicationItem.add(Items(title: key.text, description: value.text)));
      technologySection.forEach((key, value) => technologyItem.add(Items(title: key.text, description: value.text)));
      informaticsSection.forEach((key, value) => metrics.add(Metrics(label: key.text, value: value.text)));

      Get.toNamed(Routes.innovationProjectPreview, arguments: {'projectData': InnovationProjects(
          title: projectMainTitleController.text,
          description: projectDescController.text,
          category: projectSubtitleController.text,
          newImage: projectImage.value,
          metrics: metrics,
          image: null,
          applications: ApplicationsOrTechnology(
            heading: applicationSectionHeadingController.text,
            items: applicationItem,
            label: 'Applications',
          ),
          technology: ApplicationsOrTechnology(
            heading: technologySectionHeadingController.text,
            items: technologyItem,
            label: 'Technology',
          )
      )});
    }
  }
}
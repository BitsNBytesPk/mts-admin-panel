import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';
import 'package:mts_website_admin_panel/models/innovation_data.dart';
import 'package:mts_website_admin_panel/screens/innovation/content/innovation_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

class InnovationEditProjectViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController projectMainTitleController = TextEditingController();
  TextEditingController projectSubtitleController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();

  TextEditingController technologySectionHeadingController = TextEditingController();
  TextEditingController applicationSectionHeadingController = TextEditingController();

  RxMap<TextEditingController, TextEditingController> informaticsSection = <TextEditingController, TextEditingController>{}.obs;
  RxMap<TextEditingController, TextEditingController> technologySection = <TextEditingController, TextEditingController>{}.obs;
  RxMap<TextEditingController, TextEditingController> applicationSection = <TextEditingController, TextEditingController>{}.obs;
  RxMap<TextEditingController, TextEditingController> statisticsSection = <TextEditingController, TextEditingController>{}.obs;

  Rx<Uint8List> projectImage = Uint8List(0).obs;

  Rx<InnovationProjects> project = InnovationProjects().obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    final Map<String, dynamic>? args = Get.arguments;

    if(args == null || args.isEmpty) {
      Get.offAllNamed(Routes.innovationContent);
    } else {
      project.value = args['projectData'];
      _fillControllers();
    }
    super.onReady();
  }

  void _fillControllers() {
    projectMainTitleController.text = project.value.title!;
    projectSubtitleController.text = project.value.category!;
    projectDescController.text = project.value.description!;

    applicationSectionHeadingController.text = project.value.applications?.heading ?? '';
    technologySectionHeadingController.text = project.value.technology?.heading ?? '';

    project.value.metrics?.forEach((element) {
      informaticsSection.addAll({TextEditingController(text: element.label): TextEditingController(text: element.value)});
      informaticsSection.refresh();
    });

    project.value.applications?.items?.forEach((element) {
      applicationSection.addAll({TextEditingController(text: element.title): TextEditingController(text: element.description)});
    });

    project.value.technology?.items?.forEach((element) {
      technologySection.addAll({TextEditingController(text: element.title): TextEditingController(text: element.description)});
    });
  }

  void updateProject() {

    if(formKey.currentState!.validate()) {

      Map<String, dynamic> body = {};
      List<http.MultipartFile> file = [];

      List<Metrics> updatedMetrics = [];
      List<Items> updatedApplication = [];
      List<Items> updatedTechnology = [];

      body.addIf(projectMainTitleController.text != project.value.title, 'title', projectMainTitleController.text);
      body.addIf(projectDescController.text != project.value.description, 'description', projectDescController.text);
      body.addIf(projectSubtitleController.text != project.value.category, 'category', projectSubtitleController.text);
      body.addIf(applicationSectionHeadingController.text != project.value.applications?.heading, 'application_heading', applicationSectionHeadingController.text);
      body.addIf(technologySectionHeadingController.text != project.value.technology?.heading, 'technology_heading', technologySectionHeadingController.text);

      if(project.value.metrics != null && project.value.metrics!.isNotEmpty) {
        if(informaticsSection.length != project.value.metrics!.length) {
          informaticsSection.forEach((key, value) => updatedMetrics.add(Metrics(label: key.text, value: value.text)));
        } else {
          for(int i = 0; i <= project.value.metrics!.length - 1; i++) {
            updatedTechnology.addIf(
                project.value.metrics![i].label != informaticsSection.keys.elementAt(i).text
                    || project.value.metrics![i].value != informaticsSection.values.elementAt(i).text,
                Items(
                    title: informaticsSection.keys.elementAt(i).text,
                    description: informaticsSection.values.elementAt(i).text
                )
            );
          }
        }
      } else {
        if(informaticsSection.isNotEmpty) {
          informaticsSection.forEach((key, value) => updatedMetrics.add(Metrics(label: key.text, value: value.text)));
        }
      }

      if(project.value.applications != null && project.value.applications!.items != null && project.value.applications!.items!.isNotEmpty) {
        if(applicationSection.length != project.value.applications!.items!.length) {
          applicationSection.forEach((key, value) => updatedApplication.add(Items(title: key.text, description: value.text)));
        } else {
          for(int i = 0; i <= project.value.applications!.items!.length - 1; i++) {
            updatedTechnology.addIf(
                project.value.applications!.items![i].title != applicationSection.keys.elementAt(i).text
                    || project.value.applications!.items![i].description != applicationSection.values.elementAt(i).text,
                Items(
                    title: applicationSection.keys.elementAt(i).text,
                    description: applicationSection.values.elementAt(i).text
                )
            );
          }
        }
      } else {
        if(applicationSection.isNotEmpty) {
          applicationSection.forEach((key, value) => updatedApplication.add(Items(title: key.text, description: value.text)));
        }
      }

      if(project.value.technology != null && project.value.technology!.items != null && project.value.technology!.items!.isNotEmpty) {
        if(technologySection.length != project.value.technology!.items!.length) {
          technologySection.forEach((key, value) => updatedTechnology.add(Items(title: key.text, description: value.text)));
        } else {
          for(int i = 0; i <= project.value.technology!.items!.length - 1; i++) {
            updatedTechnology.addIf(
                project.value.technology!.items![i].title != technologySection.keys.elementAt(i).text
                || project.value.technology!.items![i].description != technologySection.values.elementAt(i).text,
                Items(
                  title: technologySection.keys.elementAt(i).text,
                  description: technologySection.values.elementAt(i).text
                )
            );
          }
        }
      } else {
        if(technologySection.isNotEmpty) {
          technologySection.forEach((key, value) => updatedTechnology.add(Items(title: key.text, description: value.text)));
        }
      }

      if(updatedMetrics.isNotEmpty) {
        body.addAll({'metrics': updatedMetrics.map((e) => e.toJson()).toList()});
      }

      if(updatedApplication.isNotEmpty) {
        body.addAll({'application': updatedApplication.map((e) => e.toJson()).toList()});
      }

      if(updatedTechnology.isNotEmpty) {
        body.addAll({'technology': updatedTechnology.map((e) => e.toJson()).toList()});
      }

      if(projectImage.value.isNotEmpty) {
        file.add(http.MultipartFile.fromBytes('image', projectImage.value));
      }

      if(file.isEmpty && body.isEmpty) {
        showSnackBar(message: 'No changes made', success: false);
      } else {
        GlobalVariables.showLoader.value = true;

        body.addAll({'page': 'innovation', 'index': Get.arguments['index']});

        ApiBaseHelper.patchMethodForImage(url: Urls.innovationProject, fields: body, files: file).then((value) {
          GlobalVariables.showLoader.value = false;
          if(value.success!) {

            if(Get.isRegistered<InnovationContentViewModel>()) {
              final innovationContentViewModel = Get.find<InnovationContentViewModel>();

              innovationContentViewModel.projects[Get.arguments['index']] = InnovationProjects.fromJson(value.data['updated_project']);
              innovationContentViewModel.projects.refresh();

              Get.back();

              showSnackBar(message: value.message!, success: true);
            }
          } else {
            showSnackBar(message: value.message!, success: false);
          }
        });
      }
    }
  }
}
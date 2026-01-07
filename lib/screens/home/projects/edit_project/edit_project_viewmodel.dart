import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

import '../../../../models/home_data.dart';

class HomeProjectEditViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController projectMainTitleController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();
  TextEditingController projectCtaController = TextEditingController();

  /// Form Variables
  RxnDouble projectFormHeight = RxnDouble(null);
  Rx<Uint8List> projectIcon = Uint8List(0).obs;
  RxMap<TextEditingController, TextEditingController> statisticsSection = <TextEditingController, TextEditingController>{}.obs;

  Rx<HomeInnovationCards> projectData = HomeInnovationCards().obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);

    final Map<String, dynamic>? args = Get.arguments;

    if(args == null || args.isEmpty) {
      Get.offAllNamed(Routes.homeProjects);
    } else {
      projectData = HomeInnovationCards.fromJson(args['projectData']).obs;
      _fillControllers();
    }
    super.onReady();
  }

  @override
  void onClose() {
    projectMainTitleController.dispose();
    projectDescriptionController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _fillControllers() {
    projectMainTitleController.text = projectData.value.title ?? '';
    projectDescriptionController.text = projectData.value.description ?? '';
    projectCtaController.text = projectData.value.cta?.label ?? '';

    projectData.value.metrics?.forEach((element) {
      statisticsSection.addAll({TextEditingController(text: element.label): TextEditingController(text: element.value)});
    });
  }
}
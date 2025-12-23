import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class InnovationBannerViewModel extends GetxController {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerVideoController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Rx<Uint8List> projectImage = Uint8List(0).obs;

  @override
  void onReady() async {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    pageBannerMainTitleController.dispose();
    pageBannerSubTitleController.dispose();
    pageBannerDescriptionController.dispose();
    pageBannerVideoController.dispose();
    super.onClose();
  }
}

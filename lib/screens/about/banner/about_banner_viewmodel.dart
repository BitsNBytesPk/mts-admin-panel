import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class AboutBannerViewModel extends GetxController {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Rx<Uint8List> bannerImage = Uint8List(0).obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }
}
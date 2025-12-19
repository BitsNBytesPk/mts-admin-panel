import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class HomeContentViewModel extends GetxController {

  /// Controller(s) & Global Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController secondaryBannerMainTitleController = TextEditingController();
  TextEditingController secondaryBannerSubTitleController = TextEditingController();
  TextEditingController secondaryBannerDescriptionController = TextEditingController();

  /// Secondary Home Banner Image/Video
  Rx<Uint8List> newImage = Uint8List(0).obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }
}
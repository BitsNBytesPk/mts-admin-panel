import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';

class MessagesViewModel extends GetxController {

  /// Controller(s) & Global Key(s)
  ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

}
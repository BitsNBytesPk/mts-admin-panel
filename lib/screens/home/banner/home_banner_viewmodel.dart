import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../helpers/stop_loader_and_show_snackbar.dart';
import '../../../languages/translation_keys.dart' as lang_key;
import '../../../models/message.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';
import '../models/user_summary_model.dart';

class HomeViewModel extends GetxController {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();

  RxList<Message> recentUnreadMessages = <Message>[].obs;

  Rx<Uint8List> projectImage = Uint8List(0).obs;

  @override
  void onReady() async {
    // _fetchInitialDataForDashboard();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // /// Collective API calls to fetch data for home
  // void _fetchInitialDataForDashboard() async {
  //   GlobalVariables.showLoader.value = true;
  //
  //   final fetchUserMessages = ApiBaseHelper.getMethod(url: Urls.getRecentMessages);
  //   final fetchAppsStats = ApiBaseHelper.getMethod(url: Urls.getAppsStats);
  //
  //   final responses = await Future.wait([fetchUserMessages,fetchAppsStats]);
  //
  //   if(responses[0].success! && responses[0].data != null) {
  //     final data = responses[0].data as List;
  //
  //     recentUnreadMessages.addAllIf(data.isNotEmpty, data.map((e) => Message.fromJson(e)));
  //     recentUnreadMessages.refresh();
  //   }
  //
  //   if(responses[1].success! && responses[1].data != null) {
  //     applicationsStats.value = AppsSummary.fromJson(responses[1].data);
  //   }
  //
  //   if(responses.isEmpty || responses.every((element) => !element.success!)) {
  //     showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
  //   }
  //
  //   GlobalVariables.showLoader.value = false;
  // }
}
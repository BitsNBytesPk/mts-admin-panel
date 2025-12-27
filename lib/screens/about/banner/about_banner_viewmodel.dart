import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/about_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../utils/url_paths.dart';

class AboutBannerViewModel extends GetxController {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<AboutData> aboutData = AboutData().obs;

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  late CachedVideoPlayerPlus videoController;
  RxBool isVideoControllerInitialized = false.obs;

  @override
  void onReady() {
    _fetchAboutData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void _fetchAboutData() {

    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.aboutData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        aboutData.value = AboutData.fromJson(value.data);
        _fillAboutBannerControllers();
        _getAboutBanner();
      }
    });
  }

  void _fillAboutBannerControllers() {
    pageBannerMainTitleController.text = aboutData.value.content?.hero?.title ?? '';
    pageBannerSubTitleController.text = aboutData.value.content?.hero?.subtitle ?? '';
    pageBannerDescriptionController.text = aboutData.value.content?.hero?.description ?? '';
  }

  void _getAboutBanner() async {

    videoController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(aboutData.value.content?.hero?.backgroundVideo == null ? '' : '${Urls.baseURL}${aboutData.value.content?.hero?.backgroundVideo}'),
      httpHeaders: {'Cache-Control': 'max-age=80085',},
    );
    await videoController.initialize();
    await videoController.controller.play();
    await videoController.controller.setLooping(true);
    isVideoControllerInitialized.value = true;
  }
}
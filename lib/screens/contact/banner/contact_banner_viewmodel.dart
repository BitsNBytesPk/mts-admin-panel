import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/contact_data.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class ContactBannerViewModel extends GetxController with WidgetsBindingObserver {

  /// Controller(s) & Global Key(s)
  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerCtaTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CachedVideoPlayerPlus videoPlayerController;

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  RxBool isVideoControllerInitialized = false.obs;

  Rx<ContactData> contactData = ContactData().obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() async {

    _fetchInitialDataForContactBanner();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      videoPlayerController.controller.pause();
    } else if(state == AppLifecycleState.resumed) {
      videoPlayerController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    scrollController.dispose();
    videoPlayerController.dispose();
    pageBannerMainTitleController.dispose();
    pageBannerSubTitleController.dispose();
    pageBannerDescriptionController.dispose();
    pageBannerCtaTextController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _fetchInitialDataForContactBanner() {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.contactData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        contactData.value = ContactData.fromJson(value.data);
        _fillResponsibilityBannerControllers();
        _getResponsibilityBanner();
      }
    });
  }

  void _fillResponsibilityBannerControllers() {
    pageBannerMainTitleController.text = contactData.value.content?.hero?.title ?? '';
    pageBannerSubTitleController.text = contactData.value.content?.hero?.subtitle ?? '';
    pageBannerDescriptionController.text = contactData.value.content?.hero?.description ?? '';
  }

  void _getResponsibilityBanner() async {

    videoPlayerController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(contactData.value.content?.hero?.backgroundVideo == null ? '' : '${Urls.baseURL}${contactData.value.content?.hero?.backgroundVideo}'),
      httpHeaders: {'Cache-Control': 'max-age=80085',},
    );
    await videoPlayerController.initialize();
    await videoPlayerController.controller.play();
    await videoPlayerController.controller.setLooping(true);
    isVideoControllerInitialized.value = true;
  }
}
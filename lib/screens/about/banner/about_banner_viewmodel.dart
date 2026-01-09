import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/about_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../utils/url_paths.dart';

import 'package:video_player/video_player.dart';
import '../../../helpers/banner_helpers.dart';

class AboutBannerViewModel extends GetxController with WidgetsBindingObserver {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerCtaTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<AboutData> aboutData = AboutData().obs;

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  late CachedVideoPlayerPlus networkVideoController;
  late VideoPlayerController newVideoController;
  RxBool isNetworkVideoControllerInitialized = false.obs;
  RxBool isNewVideoControllerInitialized = false.obs;
  RxBool videoLoading = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    _fetchAboutData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.inactive || state == AppLifecycleState.paused) && networkVideoController.isInitialized) {
      networkVideoController.controller.pause();
    } else if(state == AppLifecycleState.resumed && networkVideoController.isInitialized) {
      networkVideoController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    scrollController.dispose();
    pageBannerMainTitleController.dispose();
    pageBannerSubTitleController.dispose();
    pageBannerDescriptionController.dispose();
    pageBannerCtaTextController.dispose();
    networkVideoController.dispose();
    newVideoController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
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
    pageBannerCtaTextController.text = aboutData.value.content?.hero?.ctaText ?? '';
  }

  void _getAboutBanner() async {

    networkVideoController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(aboutData.value.content?.hero?.backgroundVideo == null ? '' : '${Urls.baseURL}${aboutData.value.content?.hero?.backgroundVideo}'),
      httpHeaders: {'Cache-Control': 'max-age=80085',},
    );
    await networkVideoController.initialize();
    await networkVideoController.controller.play();
    await networkVideoController.controller.setLooping(true);
    isNetworkVideoControllerInitialized.value = true;
  }

  void selectVideoFromDevice() async {
    await BannerHelpers.selectVideoFromDevice(
      videoLoading: videoLoading,
      newBanner: newBanner,
      networkVideoController: networkVideoController,
      onNewVideoControllerCreated: (controller) => newVideoController = controller,
      isNetworkVideoControllerInitialized: isNetworkVideoControllerInitialized,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      pauseNetworkVideo: (value) async => await networkVideoController.controller.pause(),
    );
  }

  void removeSelectedVideo() async {
    await BannerHelpers.removeSelectedVideo(
      newVideoController: newVideoController,
      newBanner: newBanner,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      networkVideoController: networkVideoController,
      isNetworkVideoControllerInitialized: isNetworkVideoControllerInitialized,
    );
  }

  void updateBannerData() async {
    await BannerHelpers.updateBannerData(
      formKey: formKey,
      titleController: pageBannerMainTitleController,
      subtitleController: pageBannerSubTitleController,
      descriptionController: pageBannerDescriptionController,
      ctaTextController: pageBannerCtaTextController,
      currentValues: {
        'title': aboutData.value.content?.hero?.title,
        'subtitle': aboutData.value.content?.hero?.subtitle,
        'description': aboutData.value.content?.hero?.description,
        'ctaText': aboutData.value.content?.hero?.ctaText,
      },
      newBanner: newBanner,
      page: 'about',
      networkVideoController: networkVideoController,
      newVideoController: isNewVideoControllerInitialized.value ? newVideoController : null,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      onSuccess: (va) {}, isNetworkVideoControllerInitialized: isNetworkVideoControllerInitialized,
    );
  }
}
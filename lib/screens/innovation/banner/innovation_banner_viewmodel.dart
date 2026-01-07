import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/innovation_data.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

import 'package:video_player/video_player.dart';
import '../../../helpers/banner_helpers.dart';

class InnovationBannerViewModel extends GetxController with WidgetsBindingObserver {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerVideoController = TextEditingController();
  TextEditingController pageBannerCtaTextController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  late CachedVideoPlayerPlus videoController;
  late VideoPlayerController newVideoController;
  RxBool isVideoControllerInitialized = false.obs;
  RxBool isNewVideoControllerInitialized = false.obs;
  RxBool videoLoading = false.obs;

  Rx<InnovationData> innovationData = InnovationData().obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    _fetchInnovationData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.inactive || state == AppLifecycleState.paused) && videoController.isInitialized) {
      videoController.controller.pause();
    } else if(state == AppLifecycleState.resumed && videoController.isInitialized) {
      videoController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    scrollController.dispose();
    pageBannerMainTitleController.dispose();
    pageBannerSubTitleController.dispose();
    pageBannerDescriptionController.dispose();
    pageBannerVideoController.dispose();
    pageBannerCtaTextController.dispose();
    videoController.dispose();
    newVideoController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _fetchInnovationData() {

    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.innovationData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        innovationData.value = InnovationData.fromJson(value.data);
        _fillInnovationBannerControllers();
        _getInnovationBanner();
      }
    });
  }

  void _fillInnovationBannerControllers() {
    pageBannerMainTitleController.text = innovationData.value.content?.hero?.title ?? '';
    pageBannerSubTitleController.text = innovationData.value.content?.hero?.subtitle ?? '';
    pageBannerDescriptionController.text = innovationData.value.content?.hero?.description ?? '';
    pageBannerCtaTextController.text = innovationData.value.content?.hero?.ctaText ?? '';
  }

  void _getInnovationBanner() async {

    videoController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(innovationData.value.content?.hero?.backgroundVideo == null ? '' : '${Urls.baseURL}${innovationData.value.content?.hero?.backgroundVideo}'),
      httpHeaders: {'Cache-Control': 'max-age=80085',},
    );
    await videoController.initialize();
    await videoController.controller.play();
    await videoController.controller.setLooping(true);
    isVideoControllerInitialized.value = true;
  }

  void selectVideoFromDevice() async {
    await BannerHelpers.selectVideoFromDevice(
      videoLoading: videoLoading,
      newBanner: newBanner,
      networkVideoController: videoController,
      onNewVideoControllerCreated: (controller) => newVideoController = controller,
      isNetworkVideoControllerInitialized: isVideoControllerInitialized,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      pauseNetworkVideo: (value) async => await videoController.controller.pause(),
    );
  }

  void removeSelectedVideo() async {
    await BannerHelpers.removeSelectedVideo(
      newVideoController: newVideoController,
      newBanner: newBanner,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      networkVideoController: videoController,
      isNetworkVideoControllerInitialized: isVideoControllerInitialized,
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
        'title': innovationData.value.content?.hero?.title,
        'subtitle': innovationData.value.content?.hero?.subtitle,
        'description': innovationData.value.content?.hero?.description,
        'ctaText': innovationData.value.content?.hero?.ctaText,
      },
      newBanner: newBanner,
      page: 'innovation',
      networkVideoController: videoController,
      newVideoController: isNewVideoControllerInitialized.value ? newVideoController : null,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      onSuccess: () {},
    );
  }
}

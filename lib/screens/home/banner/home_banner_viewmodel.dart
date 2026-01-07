import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:video_player/video_player.dart';

import '../../../helpers/banner_helpers.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import '../../../helpers/stop_loader_and_show_snackbar.dart';
import '../../../languages/translation_keys.dart' as lang_key;
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class HomeBannerViewModel extends GetxController with WidgetsBindingObserver {

  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerCtaTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  late CachedVideoPlayerPlus networkVideoController;
  late VideoPlayerController newVideoController;
  RxBool isNetworkVideoControllerInitialized = false.obs;
  RxBool isNewVideoControllerInitialized = false.obs;
  RxBool videoLoading = false.obs;
  RxBool bannerPreviewLoader = false.obs;

  Rx<HomeData> homeData = HomeData().obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() async {

    _fetchInitialDataForHomeBanner();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    // if((state == AppLifecycleState.inactive || state == AppLifecycleState.paused) && newVideoController.value.isInitialized) {
    //   newVideoController.pause();
    // } else if(state == AppLifecycleState.resumed && newVideoController.value.isInitialized) {
    //   newVideoController.play();
    // }

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
    networkVideoController.dispose();
    newVideoController.dispose();
    pageBannerMainTitleController.dispose();
    pageBannerSubTitleController.dispose();
    pageBannerDescriptionController.dispose();
    pageBannerCtaTextController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  /// Collective API calls to fetch data for home
  void _fetchInitialDataForHomeBanner() async {
    GlobalVariables.showLoader.value = true;

    final fetchHomeData = ApiBaseHelper.getMethod(url: Urls.homeData);

    final responses = await Future.wait([fetchHomeData]);

    if(responses[0].success! && responses[0].data != null) {

      homeData.value = HomeData.fromJson(responses[0].data);// if(responses[1].success! && responses[1].data != null) {
    //   applicationsStats.value = AppsSummary.fromJson(responses[1].data);

      _fillHomeBannerDataAndFetchFile();
      _getHomeBanner();
      // recentUnreadMessages.refresh();
    }

    // if(responses[1].success! && responses[1].data != null) {
    //   applicationsStats.value = AppsSummary.fromJson(responses[1].data);
    // }

    if(responses.isEmpty || responses.every((element) => !element.success!)) {
      showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
    }

    GlobalVariables.showLoader.value = false;
  }

  void _fillHomeBannerDataAndFetchFile() {
    pageBannerMainTitleController.text = homeData.value.content?.hero?.title ?? '';
    pageBannerSubTitleController.text = homeData.value.content?.hero?.subtitle ?? '';
    pageBannerDescriptionController.text = homeData.value.content?.hero?.description ?? '';
    pageBannerCtaTextController.text = homeData.value.content?.hero?.ctaText ?? '';

  }

  void _getHomeBanner() async {
    networkVideoController = CachedVideoPlayerPlus.networkUrl(
        Uri.parse(homeData.value.content?.hero?.backgroundVideo == null ? '' : '${Urls.baseURL}${homeData.value.content?.hero?.backgroundVideo}'),
      httpHeaders: {
        'Cache-Control': 'max-age=80085',
      },
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
        'title': homeData.value.content?.hero?.title,
        'subtitle': homeData.value.content?.hero?.subtitle,
        'description': homeData.value.content?.hero?.description,
        'ctaText': homeData.value.content?.hero?.ctaText,
      },
      newBanner: newBanner,
      page: 'home',
      networkVideoController: networkVideoController,
      newVideoController: isNewVideoControllerInitialized.value ? newVideoController : null,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      onSuccess: () {},
    );
  }
}
import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class HomeContentViewModel extends GetxController with WidgetsBindingObserver {

  /// Controller(s) & Global Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController secondaryBannerMainTitleController = TextEditingController();
  TextEditingController secondaryBannerSubTitleController = TextEditingController();
  TextEditingController secondaryBannerDescriptionController = TextEditingController();
  TextEditingController ourMissionHeadingController = TextEditingController();
  TextEditingController ourMissionDescController = TextEditingController();
  GlobalKey<FormState> secondaryBannerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ourMissionFormKey = GlobalKey<FormState>();

  /// Secondary Home Banner Image/Video
  Rx<Uint8List> newImage = Uint8List(0).obs;

  Rx<HomeData> homeData = HomeData().obs;

  /// Heights variables for sections.
  RxnDouble secondaryBannerHeight = RxnDouble(kSectionHeightValue);
  RxnDouble ourMissionHeight = RxnDouble(kSectionHeightValue);

  late CachedVideoPlayerPlus videoController;
  RxBool isVideoControllerInitialized = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    _fetchHomeData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      videoController.controller.pause();
    } else if(state == AppLifecycleState.resumed) {
      videoController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    videoController.dispose();
    scrollController.dispose();
    secondaryBannerDescriptionController.dispose();
    secondaryBannerSubTitleController.dispose();
    secondaryBannerMainTitleController.dispose();
    ourMissionHeadingController.dispose();
    ourMissionDescController.dispose();
    super.onClose();
  }

  void _fetchHomeData() {

    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.homeData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        homeData.value = HomeData.fromJson(value.data);
        _getSecondaryBanner();
        _fillControllers();
      }
    });
  }

  void _fillControllers() {
    ourMissionHeadingController.text = homeData.value.content?.mission?.heading ?? '';
    ourMissionDescController.text = homeData.value.content?.mission?.subheading ?? '';
    secondaryBannerMainTitleController.text = homeData.value.content?.responsibilityTeaser?.heading ?? '';
    secondaryBannerSubTitleController.text = homeData.value.content?.responsibilityTeaser?.label ?? '';
    secondaryBannerDescriptionController.text = homeData.value.content?.responsibilityTeaser?.description ?? '';
  }

  void _getSecondaryBanner() async {
    videoController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(homeData.value.content?.responsibilityTeaser?.backgroundVideo == null ? '' : '${Urls.baseURL}${homeData.value.content?.responsibilityTeaser?.backgroundVideo}'),
      httpHeaders: {
        'Cache-Control': 'max-age=80085',
      },
    );
    await videoController.initialize();
    await videoController.controller.play();
    await videoController.controller.setLooping(true);
    isVideoControllerInitialized.value = true;
  }
}
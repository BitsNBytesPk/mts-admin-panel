import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/page_banner.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

class BannerPreviewViewModel extends GetxController with WidgetsBindingObserver {

  late CachedVideoPlayerPlus videoPlayerController;

  Rx<PageBannerModel> bannerData = PageBannerModel().obs;

  RxBool isVideoControllerInitialized = false.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() async {
    final Map<String, dynamic>? args = Get.arguments;
    if(args != null) {
      if(args.containsKey('bannerData')) {
        bannerData.value = PageBannerModel.fromJson(args['bannerData']);

        if(bannerData.value.newBanner != null) {
          // videoPlayerController = CachedVideoPlayerPlus.file(file);
          // await videoPlayerController.initialize();
        } else if(bannerData.value.uploadedBanner != null) {
          videoPlayerController = CachedVideoPlayerPlus.networkUrl(Uri.parse(bannerData.value.uploadedBanner!));
          await videoPlayerController.initialize();
          await videoPlayerController.controller.play();
          await videoPlayerController.controller.setLooping(true);
          isVideoControllerInitialized.value = true;
        }
      } else {
        Get.offAllNamed(Routes.homeBanner);
      }
    } else {
      Get.offAllNamed(Routes.homeBanner);
    }

    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if ((state == AppLifecycleState.inactive || state == AppLifecycleState.paused) && isVideoControllerInitialized.value) {
      videoPlayerController.controller.pause();
    } else if(state == AppLifecycleState.resumed && isVideoControllerInitialized.value) {
      videoPlayerController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    if(videoPlayerController.isInitialized) {
      videoPlayerController.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
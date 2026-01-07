import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';
import 'package:mts_website_admin_panel/models/page_banner.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:video_player/video_player.dart';

class BannerPreviewViewModel extends GetxController with WidgetsBindingObserver {

  late VideoPlayerController videoPlayerController;

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
        bannerData.value = args['bannerData'];

        if(bannerData.value.newBanner != null && bannerData.value.newBanner!.isNotEmpty) {
          final blob = XFile.fromData(bannerData.value.newBanner!);
          videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(blob.path));

          await videoPlayerController.initialize();
          await videoPlayerController.setLooping(true);
          await videoPlayerController.play();
          isVideoControllerInitialized.value = true;
        } else if(bannerData.value.uploadedBanner != null) {
          videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(bannerData.value.uploadedBanner!));
          await videoPlayerController.initialize();
          await videoPlayerController.play();
          await videoPlayerController.setLooping(true);
          isVideoControllerInitialized.value = true;
        } else {
          Get.offAllNamed(Routes.homeBanner);
          showSnackBar(message: 'No Banner Found', success: false);
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
      videoPlayerController.pause();
    } else if(state == AppLifecycleState.resumed && isVideoControllerInitialized.value) {
      videoPlayerController.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
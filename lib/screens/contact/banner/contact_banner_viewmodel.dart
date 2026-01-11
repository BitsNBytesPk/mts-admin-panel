import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/contact_data.dart';

import '../../../helpers/scroll_controller_funcs.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

import 'package:video_player/video_player.dart';
import '../../../helpers/banner_helpers.dart';

class ContactBannerViewModel extends GetxController with WidgetsBindingObserver {

  /// Controller(s) & Global Key(s)
  TextEditingController pageBannerMainTitleController = TextEditingController();
  TextEditingController pageBannerSubTitleController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();
  TextEditingController pageBannerCtaTextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CachedVideoPlayerPlus videoPlayerController;
  late VideoPlayerController newVideoController;

  Rx<Uint8List> newBanner = Uint8List(0).obs;
  RxBool isVideoControllerInitialized = false.obs;
  RxBool isNewVideoControllerInitialized = false.obs;
  RxBool videoLoading = false.obs;

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
    if ((state == AppLifecycleState.inactive || state == AppLifecycleState.paused) && videoPlayerController.isInitialized) {
      videoPlayerController.controller.pause();
    } else if(state == AppLifecycleState.resumed && videoPlayerController.isInitialized) {
      videoPlayerController.controller.play();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    scrollController.dispose();
    videoPlayerController.dispose();
    newVideoController.dispose();
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
    // pageBannerCtaTextController.text = contactData.value.content?.hero?.ctaText ?? '';
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

  void selectVideoFromDevice() async {
    await BannerHelpers.selectVideoFromDevice(
      videoLoading: videoLoading,
      newBanner: newBanner,
      networkVideoController: videoPlayerController,
      onNewVideoControllerCreated: (controller) => newVideoController = controller,
      isNetworkVideoControllerInitialized: isVideoControllerInitialized,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      pauseNetworkVideo: (value) async => await videoPlayerController.controller.pause(),
    );
  }

  void removeSelectedVideo() async {
    await BannerHelpers.removeSelectedVideo(
      newVideoController: newVideoController,
      newBanner: newBanner,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      networkVideoController: videoPlayerController,
      isNetworkVideoControllerInitialized: isVideoControllerInitialized,
    );
  }

  void updateBannerData() async {
    await BannerHelpers.updateBannerData(
      fileName: 'contact_hero',
      formKey: formKey,
      isNetworkVideoControllerInitialized: isVideoControllerInitialized,
      titleController: pageBannerMainTitleController,
      subtitleController: pageBannerSubTitleController,
      descriptionController: pageBannerDescriptionController,
      ctaTextController: pageBannerCtaTextController,
      currentValues: {
        'title': contactData.value.content?.hero?.title,
        'subtitle': contactData.value.content?.hero?.subtitle,
        'description': contactData.value.content?.hero?.description,
        // 'ctaText': contactData.value.content?.hero?.ctaText,
      },
      newBanner: newBanner,
      page: 'home',
      networkVideoController: videoPlayerController,
      newVideoController: isNewVideoControllerInitialized.value ? newVideoController : null,
      isNewVideoControllerInitialized: isNewVideoControllerInitialized,
      onSuccess: (newVideoUrl) async {

        isVideoControllerInitialized.value = false;
        await videoPlayerController.controller.pause();
        await videoPlayerController.dispose();

        newBanner.value = Uint8List(0);
        if(isNewVideoControllerInitialized.value) {
          await newVideoController.dispose();
          isNewVideoControllerInitialized.value = false;
        }

        videoPlayerController = CachedVideoPlayerPlus.networkUrl(
          Uri.parse(newVideoUrl == null ? '' : '${Urls.baseURL}$newVideoUrl?t=${DateTime.now().millisecondsSinceEpoch}'),
          httpHeaders: {
            'Cache-Control': 'max-age=80085',
          },
        );

        Future.delayed(Duration(milliseconds: 250), () async {
          await videoPlayerController.initialize();
          isVideoControllerInitialized.value = true;
          await videoPlayerController.controller.play();
          await videoPlayerController.controller.setLooping(true);
        });
      },
    );
  }
}
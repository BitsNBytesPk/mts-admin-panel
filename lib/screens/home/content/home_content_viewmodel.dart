import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';
import 'package:video_player/video_player.dart';

import '../../../helpers/banner_helpers.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import '../../../helpers/stop_loader_and_show_snackbar.dart';

class HomeContentViewModel extends GetxController with WidgetsBindingObserver {

  /// Controller(s) & Global Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController secondaryBannerMainTitleController = TextEditingController();
  TextEditingController secondaryBannerSubTitleController = TextEditingController();
  TextEditingController secondaryBannerDescriptionController = TextEditingController();
  TextEditingController secondaryBannerCtaController = TextEditingController();
  TextEditingController ourMissionHeadingController = TextEditingController();
  TextEditingController ourMissionDescController = TextEditingController();
  GlobalKey<FormState> secondaryBannerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ourMissionFormKey = GlobalKey<FormState>();

  /// Secondary Home Banner Video
  Rx<Uint8List> newBanner = Uint8List(0).obs;

  Rx<HomeData> homeData = HomeData().obs;

  /// Heights variables for sections.
  RxnDouble secondaryBannerHeight = RxnDouble(null);
  RxnDouble ourMissionHeight = RxnDouble(kSectionContainerHeightValue);

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
    _fetchHomeData();
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
    networkVideoController.dispose();
    newVideoController.dispose();
    scrollController.dispose();
    secondaryBannerDescriptionController.dispose();
    secondaryBannerSubTitleController.dispose();
    secondaryBannerMainTitleController.dispose();
    secondaryBannerCtaController.dispose();
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
    secondaryBannerCtaController.text = homeData.value.content?.responsibilityTeaser?.ctaText ?? '';
  }

  void _getSecondaryBanner() async {
    networkVideoController = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(homeData.value.content?.responsibilityTeaser?.backgroundVideo == null ? '' : '${Urls.baseURL}${homeData.value.content?.responsibilityTeaser?.backgroundVideo}'),
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

    if (secondaryBannerFormKey.currentState!.validate()) {
      Map<String, dynamic> body = {};
      List<http.MultipartFile> file = [];

      body.addIf(secondaryBannerMainTitleController.text != homeData.value.content?.responsibilityTeaser?.heading, 'heading', secondaryBannerMainTitleController.text);
      body.addIf(secondaryBannerSubTitleController.text != homeData.value.content?.responsibilityTeaser?.label, 'label', secondaryBannerSubTitleController.text);
      body.addIf(secondaryBannerDescriptionController.text != homeData.value.content?.responsibilityTeaser?.description, 'description', secondaryBannerDescriptionController.text);
      body.addIf(secondaryBannerCtaController.text != homeData.value.content?.responsibilityTeaser?.ctaText, 'ctaText', secondaryBannerCtaController.text);

      if (newBanner.value.isNotEmpty) {
        file.add(http.MultipartFile.fromBytes('backgroundVideo', newBanner.value, filename: 'responsibility_teaser.mp4'));
      }

      if (body.isEmpty && file.isEmpty) {
        showSnackBar(message: 'No details updated', success: false);
      } else {
        GlobalVariables.showLoader.value = true;

        ApiBaseHelper.patchMethodForImage(
            url: Urls.updateHomeResponsibilityTeaser,
            files: file,
            fields: body
        ).then((value) async {
          stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

          if (value.success!) {
            if(newBanner.value.isNotEmpty) {
              isNetworkVideoControllerInitialized.value = false;
              await networkVideoController.controller.pause();
              await networkVideoController.dispose();

              newBanner.value = Uint8List(0);

              if(isNewVideoControllerInitialized.value) {
                await newVideoController.dispose();
                isNewVideoControllerInitialized.value = false;
              }
            }

            final Map<String, dynamic>? newData = value.data['updates'];
            if(newData != null) {
              if(newData.containsKey('backgroundVideo')) {
                networkVideoController = CachedVideoPlayerPlus.networkUrl(
                  Uri.parse(newData['backgroundVideo'] == null ? '' : '${Urls.baseURL}${newData['backgroundVideo']}?t=${DateTime.now().millisecondsSinceEpoch}'),
                  httpHeaders: {
                    'Cache-Control': 'max-age=80085',
                  },
                );
              }

              if(newData.containsKey('ctaText')) {
                homeData.value.content?.responsibilityTeaser?.ctaText = newData['ctaText'];
              }

              if(newData.containsKey('label')) {
                homeData.value.content?.responsibilityTeaser?.label = newData['label'];
              }

              if(newData.containsKey('heading')) {
                homeData.value.content?.responsibilityTeaser?.ctaText = newData['heading'];
              }

              if(newData.containsKey('description')) {
                homeData.value.content?.responsibilityTeaser?.description = newData['description'];
              }

              if(newData.containsKey('backgroundVideo')) {
                Future.delayed(Duration(milliseconds: 250), () async {
                  await networkVideoController.initialize();
                  isNetworkVideoControllerInitialized.value = true;
                  await networkVideoController.controller.play();
                  await networkVideoController.controller.setLooping(true);
                });
              }
            }
          } else {
            showSnackBar(message: value.message!, success: false);
          }
        });
      }
    }

    // await BannerHelpers.updateBannerData(
    //   fileFieldName: 'backgroundVideo',
    //   fileName: 'responsibility_teaser',
    //   formKey: secondaryBannerFormKey,
    //   isNetworkVideoControllerInitialized: isNetworkVideoControllerInitialized,
    //   titleController: secondaryBannerMainTitleController,
    //   subtitleController: secondaryBannerSubTitleController,
    //   descriptionController: secondaryBannerDescriptionController,
    //   ctaTextController: secondaryBannerCtaController,
    //   currentValues: {
    //     'heading': homeData.value.content?.responsibilityTeaser?.heading,
    //     'label': homeData.value.content?.responsibilityTeaser?.label,
    //     'description': homeData.value.content?.responsibilityTeaser?.description,
    //     'ctaText': homeData.value.content?.responsibilityTeaser?.ctaText,
    //   },
    //   newBanner: newBanner,
    //   // page: 'home',
    //   networkVideoController: networkVideoController,
    //   newVideoController: isNewVideoControllerInitialized.value ? newVideoController : null,
    //   isNewVideoControllerInitialized: isNewVideoControllerInitialized,
    //   url: Urls.updateHomeResponsibilityTeaser,
    //   onSuccess: (data) async {
    //

    //   },
    // );
  }
}
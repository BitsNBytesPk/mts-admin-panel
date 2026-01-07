import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/home_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/file_picker_functions.dart';
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
  RxnDouble secondaryBannerHeight = RxnDouble(kSectionContainerHeightValue);
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
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      networkVideoController.controller.pause();
    } else if(state == AppLifecycleState.resumed) {
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
    videoLoading.value = true;
    final newVideo = await FilePickerFunctions.pickSingleVideo();
    if(newVideo != null) {

      newBanner.value = newVideo.files.first.bytes!;

      await Future.delayed(Duration.zero);

      final blob = XFile.fromData(newBanner.value, mimeType: 'video/mp4');
      newVideoController = VideoPlayerController.networkUrl(Uri.parse(blob.path));

      await networkVideoController.controller.pause();
      isNetworkVideoControllerInitialized.value = false;

      await newVideoController.initialize();
      await newVideoController.setLooping(true);
      await newVideoController.play();
      isNewVideoControllerInitialized.value = true;

      videoLoading.value = false;
    } else {
      videoLoading.value = false;
    }
  }

  void removeSelectedVideo() async {
    newVideoController.dispose();
    newBanner.value = Uint8List(0);
    isNewVideoControllerInitialized.value = false;

    isNetworkVideoControllerInitialized.value = true;
    Future.delayed(Duration(milliseconds: 250), () async => await networkVideoController.controller.play());
  }

  void updateBannerData() async {

    if(secondaryBannerFormKey.currentState!.validate()) {
      final body = {};
      List<http.MultipartFile> file = [];

      body.addIf(secondaryBannerMainTitleController.text != homeData.value.content?.responsibilityTeaser?.heading, 'heading', secondaryBannerMainTitleController.text);
      body.addIf(secondaryBannerSubTitleController.text != homeData.value.content?.responsibilityTeaser?.label, 'label', secondaryBannerSubTitleController.text);
      body.addIf(secondaryBannerDescriptionController.text != homeData.value.content?.responsibilityTeaser?.description, 'description', secondaryBannerDescriptionController.text);
      body.addIf(secondaryBannerCtaController.text != homeData.value.content?.responsibilityTeaser?.ctaText, 'ctaText', secondaryBannerCtaController.text);

      if(newBanner.value.isNotEmpty) {
        // file.add(await http.MultipartFile.fromBytes('field', value))
      }
      
      if(file.isEmpty && body.isEmpty) {
        showSnackBar(message: 'No changes made', success: false);
      } else {
        // ApiBaseHelper.patchMethodForImage(url: url, files: files, fields: fields)
      }
    }

  }
}
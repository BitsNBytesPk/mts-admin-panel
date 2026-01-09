import 'dart:typed_data';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../helpers/file_picker_functions.dart';
import '../helpers/stop_loader_and_show_snackbar.dart';
import '../utils/api_base_helper.dart';
import '../utils/global_variables.dart';
import '../utils/url_paths.dart';

class BannerHelpers {

  static Future<void> selectVideoFromDevice({
    required RxBool videoLoading,
    required Rx<Uint8List> newBanner,
    required CachedVideoPlayerPlus networkVideoController,
    required Function(VideoPlayerController) onNewVideoControllerCreated,
    required RxBool isNetworkVideoControllerInitialized,
    required RxBool isNewVideoControllerInitialized,
    required Function(bool) pauseNetworkVideo,
  }) async {
    videoLoading.value = true;
    final newVideo = await FilePickerFunctions.pickSingleVideo();
    if (newVideo != null) {
      newBanner.value = newVideo.files.first.bytes!;

      await Future.delayed(Duration.zero);

      final blob = XFile.fromData(newBanner.value, mimeType: 'video/${newVideo.files.first.extension}');
      final newVideoController = VideoPlayerController.networkUrl(Uri.parse(blob.path));

      if (networkVideoController.isInitialized) {
        await pauseNetworkVideo(true);
        isNetworkVideoControllerInitialized.value = false;
      }

      await newVideoController.initialize();
      await newVideoController.setLooping(true);
      await newVideoController.play();

      onNewVideoControllerCreated(newVideoController);
      isNewVideoControllerInitialized.value = true;

      videoLoading.value = false;
    } else {
      videoLoading.value = false;
    }
  }

  static Future<void> removeSelectedVideo({
    required VideoPlayerController newVideoController,
    required Rx<Uint8List> newBanner,
    required RxBool isNewVideoControllerInitialized,
    required CachedVideoPlayerPlus networkVideoController,
    required RxBool isNetworkVideoControllerInitialized,
  }) async {
    await newVideoController.dispose();
    newBanner.value = Uint8List(0);
    isNewVideoControllerInitialized.value = false;

    if (networkVideoController.isInitialized) {
      isNetworkVideoControllerInitialized.value = true;
      Future.delayed(Duration(milliseconds: 250), () async => await networkVideoController.controller.play());
    }
  }

  static Future<void> updateBannerData({
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController subtitleController,
    required TextEditingController descriptionController,
    required TextEditingController ctaTextController,
    required Map<String, String?> currentValues,
    required Rx<Uint8List> newBanner,
    required String page,
    required CachedVideoPlayerPlus networkVideoController,
    required VideoPlayerController? newVideoController,
    required RxBool isNewVideoControllerInitialized,
    required RxBool isNetworkVideoControllerInitialized,
    required Function(String? newVideoUrl) onSuccess,
  }) async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> body = {};
      List<http.MultipartFile> file = [];

      body.addIf(titleController.text != currentValues['title'], 'title', titleController.text);
      body.addIf(subtitleController.text != currentValues['subtitle'], 'subtitle', subtitleController.text);
      body.addIf(descriptionController.text != currentValues['description'], 'description', descriptionController.text);
      body.addIf(ctaTextController.text != currentValues['ctaText'], 'ctaText', ctaTextController.text);

      if (newBanner.value.isNotEmpty) {
        file.add(http.MultipartFile.fromBytes('file', newBanner.value, filename: 'video.mp4'));
      }

      if (body.isEmpty && file.isEmpty) {
        showSnackBar(message: 'No details updated', success: false);
      } else {
        body.addAll({'page': page});
        GlobalVariables.showLoader.value = true;

        ApiBaseHelper.patchMethodForImage(url: Urls.updateHero, files: file, fields: body).then((value) async {
          stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

          if (value.success!) {
            onSuccess(value.data['changes']['hero.backgroundVideo']);
          } else {
            showSnackBar(message: value.message!, success: false);
          }
        });
      }
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/banner_preview/banner_preview_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:video_player/video_player.dart';

class BannerPreviewView extends StatelessWidget {
  BannerPreviewView({super.key});

  final BannerPreviewViewModel _viewModel = Get.put(BannerPreviewViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: Obx(() => _viewModel.isVideoControllerInitialized.isTrue ? Stack(
            alignment: AlignmentGeometry.center,
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: _viewModel.videoPlayerController?.controller.value.size.width,
                      height: _viewModel.videoPlayerController?.controller.value.size.height,
                      child: VideoPlayer(_viewModel.videoPlayerController!.controller),
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: ColoredBox(color: Colors.lightBlue.withValues(alpha: 0.18)),
                ),
                SizedBox(
                  width: isSmallScreen(context) ? MediaQuery.sizeOf(context).width * 0.85 : 700,
                  child: Column(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _viewModel.bannerData.value.subtitle?.toUpperCase() ?? '',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: pageBannerSubtitleTextColor,
                          fontSize: 13
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                            _viewModel.bannerData.value.title ?? '',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: primaryWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: isSmallScreen(context) ? 50 : 60
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          _viewModel.bannerData.value.description ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: primaryWhite,
                              // fontSize: 15,
                              fontWeight: FontWeight.w300
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ) : Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: primaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

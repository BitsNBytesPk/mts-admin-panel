import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/page_banner.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

import '../../../utils/custom_widgets/page_banner.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import 'home_banner_viewmodel.dart';

class HomeBannerView extends StatelessWidget {
  HomeBannerView({super.key});

  final HomeBannerViewModel _viewModel = Get.put(HomeBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 0,
        children: [
          Obx(() => PageBanner(
                mainTitleController: _viewModel.pageBannerMainTitleController,
                subtitleController: _viewModel.pageBannerSubTitleController,
                descriptionController: _viewModel.pageBannerDescriptionController,
                ctaTextController: _viewModel.pageBannerCtaTextController,
                includeCta: true,
                isVideoControllerInitialized: _viewModel.isVideoControllerInitialized.value,
                newVideo: _viewModel.newBanner,
                fileInstructions: 'File Format - .mp4, .WebM - Maximum Size 5MB',
                videoController: _viewModel.isVideoControllerInitialized.value ? _viewModel.videoController.controller : null,
                // videoPlayerFuture: _viewModel.initializeVideoPlayerFuture,
            ),
          ),
          Row(
            spacing: 15,
            mainAxisAlignment: isSmallScreen(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomMaterialButton(
                  buttonColor: Colors.deepOrangeAccent,
                    borderColor: Colors.deepOrangeAccent,
                    onPressed: () => Get.toNamed(
                      Routes.bannerPreview,
                      arguments: {
                        'bannerData': PageBannerModel(
                          title: _viewModel.pageBannerMainTitleController.text,
                          subtitle: _viewModel.pageBannerSubTitleController.text,
                          description: _viewModel.pageBannerDescriptionController.text,
                          ctaText: _viewModel.pageBannerCtaTextController.text,
                          newBanner: _viewModel.newBanner.value.isEmpty ? null : _viewModel.newBanner.value,
                          uploadedBanner: _viewModel.newBanner.value.isEmpty ? _viewModel.videoController.dataSource : null,
                        ).toJson()
                      },
                    ),
                  text: 'Show Preview',
                  width: isSmallScreen(context) ? double.infinity : 150,
                ),
              ),
              Expanded(
                child: CustomMaterialButton(
                    onPressed: () {},
                  text: 'Save',
                  width: isSmallScreen(context) ? double.infinity : 150,
                ),
              ),
            ],
          )
        ]
    );
  }
}
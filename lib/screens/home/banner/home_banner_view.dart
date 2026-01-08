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
            isNewVideoControllerInitialized: _viewModel.isNewVideoControllerInitialized,
            videoLoading: _viewModel.videoLoading,
            closeOnTap: () => _viewModel.removeSelectedVideo(),
            newVideoController: _viewModel.isNewVideoControllerInitialized.value ? _viewModel.newVideoController : null,
            formKey: _viewModel.formKey,
            mainTitleController: _viewModel.pageBannerMainTitleController,
            subtitleController: _viewModel.pageBannerSubTitleController,
            descriptionController: _viewModel.pageBannerDescriptionController,
            ctaTextController: _viewModel.pageBannerCtaTextController,
            includeCta: true,
            isNetworkVideoControllerInitialized: _viewModel.isNetworkVideoControllerInitialized,
            newVideo: _viewModel.newBanner,
            networkVideoController: _viewModel.isNetworkVideoControllerInitialized.value ? _viewModel.networkVideoController : null,
            bannerOnTap: () => _viewModel.selectVideoFromDevice(),

          )),
          Row(
            spacing: 15,
            mainAxisAlignment: isSmallScreen(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomMaterialButton(
                  buttonColor: Colors.deepOrangeAccent,
                    borderColor: Colors.deepOrangeAccent,
                    onPressed: () {
                      _viewModel.bannerPreviewLoader.value = true;
                      Get.toNamed(
                        Routes.bannerPreview,
                        arguments: {
                          'bannerData': PageBannerModel(
                            title: _viewModel.pageBannerMainTitleController.text,
                            subtitle: _viewModel.pageBannerSubTitleController.text,
                            description: _viewModel.pageBannerDescriptionController.text,
                            ctaText: _viewModel.pageBannerCtaTextController.text,
                            newBanner: _viewModel.newBanner.value.isEmpty ? null : _viewModel.newBanner.value,
                            uploadedBanner: _viewModel.newBanner.value.isEmpty ? _viewModel.networkVideoController.dataSource : null,
                          )
                        },
                      );
                      _viewModel.bannerPreviewLoader.value = false;
                    },
                  text: _viewModel.bannerPreviewLoader.isFalse ? 'Show Preview' : null,
                  width: isSmallScreen(context) ? double.infinity : 150,
                  child: _viewModel.bannerPreviewLoader.isFalse ? null : Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: primaryWhite,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomMaterialButton(
                    onPressed: () => _viewModel.updateBannerData(),
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
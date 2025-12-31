import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../models/page_banner.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/custom_material_button.dart';
import '../../../utils/custom_widgets/page_banner.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/routes.dart';
import 'about_banner_viewmodel.dart';

class AboutBannerView extends StatelessWidget {
  AboutBannerView({super.key});

  final AboutBannerViewModel _viewModel = Get.put(AboutBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 4,
        children: [
          Obx(() => PageBanner(
            isVideoControllerInitialized: _viewModel.isVideoControllerInitialized.value,
            newVideo: _viewModel.newBanner,
            videoController: _viewModel.isVideoControllerInitialized.value ? _viewModel.videoController.controller : null,
            mainTitleController: _viewModel.pageBannerMainTitleController,
            subtitleController: _viewModel.pageBannerSubTitleController,
            descriptionController: _viewModel.pageBannerDescriptionController,
            formKey: _viewModel.formKey,
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
                  onPressed: () => Get.toNamed(
                    Routes.bannerPreview,
                    arguments: {
                      'bannerData': PageBannerModel(
                        title: _viewModel.pageBannerMainTitleController.text,
                        subtitle: _viewModel.pageBannerSubTitleController.text,
                        description: _viewModel.pageBannerDescriptionController.text,
                        // ctaText: _viewModel.pageBannerCtaTextController.text,
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
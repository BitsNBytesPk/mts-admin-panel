
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/page_banner.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/custom_material_button.dart';
import '../../../utils/custom_widgets/page_banner.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/routes.dart';
import 'innovation_banner_viewmodel.dart';

class InnovationBannerView extends StatelessWidget {
  InnovationBannerView({super.key});

  final InnovationBannerViewModel _viewModel = Get.put(InnovationBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 6,
        children: [
          Obx(() => PageBanner(
            isNewVideoControllerInitialized: _viewModel.isNewVideoControllerInitialized,
            videoLoading: _viewModel.videoLoading,
            newVideoController: _viewModel.isNewVideoControllerInitialized.value ? _viewModel.newVideoController : null,
            // newVideoController: VideoPlayerController.file(File('')),
              mainTitleController: _viewModel.pageBannerMainTitleController,
              subtitleController: _viewModel.pageBannerSubTitleController,
              descriptionController: _viewModel.pageBannerDescriptionController,
              newVideo: _viewModel.newBanner,
              formKey: _viewModel.formKey,
              includeCta: false,
              isNetworkVideoControllerInitialized: _viewModel.isVideoControllerInitialized,
              networkVideoController: _viewModel.isVideoControllerInitialized.value ? _viewModel.videoController : null,
            bannerOnTap: () {  },
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
                  onPressed: () => _viewModel.updateBannerData(),
                  text: 'Save',
                  width: isSmallScreen(context) ? double.infinity : 150,
                ),
              ),
            ],
          ),
        ]
    );
  }
}

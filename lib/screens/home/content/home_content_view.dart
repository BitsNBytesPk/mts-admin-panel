
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/home/content/home_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';

import '../../../utils/custom_widgets/page_banner.dart';

class HomeContentView extends StatelessWidget {
  HomeContentView({super.key});

  final HomeContentViewModel _viewModel = Get.put(HomeContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 1,
        scrollController: _viewModel.scrollController,
        children: [
          // SectionContainer(
          //   headingText: 'Our Mission',
          //   formKey: _viewModel.ourMissionFormKey,
          //   height: _viewModel.ourMissionHeight,
          //     children: [
          //       CustomTextFormField(
          //         title: 'Heading Text',
          //         includeAsterisk: true,
          //         controller: _viewModel.ourMissionHeadingController,
          //         showCounter: true,
          //         maxLength: 50,
          //         validator: (value) => Validators.validateEmptyField(value),
          //       ),
          //       CustomTextFormField(
          //         title: 'Description',
          //         includeAsterisk: true,
          //         maxLength: 70,
          //         controller: _viewModel.ourMissionDescController,
          //         maxLines: 3,
          //         showCounter: true,
          //         validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 70),
          //       ),
          //     ]
          // ),
          SectionContainer(
            height: _viewModel.secondaryBannerHeight,
            headingText: 'Secondary Banner',

              children: [
                Obx(() => PageBanner(
                  includeCta: true,
                  ctaTextController: _viewModel.secondaryBannerCtaController,
                  isNewVideoControllerInitialized: _viewModel.isNewVideoControllerInitialized,
                  videoLoading: _viewModel.videoLoading,
                  closeOnTap: () => _viewModel.removeSelectedVideo(),
                  bannerOnTap: () => _viewModel.selectVideoFromDevice(),
                  newVideoController: _viewModel.isNewVideoControllerInitialized.value ? _viewModel.newVideoController : null,
                  includeButtons: true,
                  formKey: _viewModel.secondaryBannerFormKey,
                  networkVideoController: _viewModel.isNetworkVideoControllerInitialized.value ? _viewModel.networkVideoController : null,
                  includeTopTitle: false,
                  mainTitleController: _viewModel.secondaryBannerMainTitleController,
                  subtitleController: _viewModel.secondaryBannerSubTitleController,
                  descriptionController: _viewModel.secondaryBannerDescriptionController,
                  newVideo: _viewModel.newBanner,
                  isNetworkVideoControllerInitialized: _viewModel.isNetworkVideoControllerInitialized,
                ))
              ]
          ),
        ]
    );
  }
}
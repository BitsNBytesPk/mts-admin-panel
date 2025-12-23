import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../utils/custom_widgets/screens_base_widget.dart';
import 'about_banner_viewmodel.dart';

class AboutBannerView extends StatelessWidget {
  AboutBannerView({super.key});

  final AboutBannerViewModel _viewModel = Get.put(AboutBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 3,
        children: [
          // PageBanner(
          //     mainTitleController: _viewModel.pageBannerMainTitleController,
          //     subtitleController: _viewModel.pageBannerSubTitleController,
          //     descriptionController: _viewModel.pageBannerDescriptionController,
          //     newVideo: _viewModel.bannerImage
          // )
        ]
    );
  }
}
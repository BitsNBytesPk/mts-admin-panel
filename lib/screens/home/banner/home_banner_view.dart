import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../languages/translation_keys.dart' as lang_key;
import '../../../utils/custom_widgets/page_banner.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/custom_widgets/heading_texts.dart';
import 'home_banner_viewmodel.dart';

class HomeBannerView extends StatelessWidget {
  HomeBannerView({super.key});

  final HomeViewModel _viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 0,
        children: [
          PageBanner(
              mainTitleController: _viewModel.pageBannerMainTitleController,
              subtitleController: _viewModel.pageBannerSubTitleController,
              descriptionController: _viewModel.pageBannerDescriptionController,
              newImage: _viewModel.projectImage
          )
        ]
    );
  }
}
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/contact/banner/contact_banner_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/page_banner.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../models/page_banner.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/custom_material_button.dart';
import '../../../utils/routes.dart';

class ContactBannerView extends StatelessWidget {
  ContactBannerView({super.key});

  final ContactBannerViewModel _viewModel = Get.put(ContactBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 11,
        scrollController: _viewModel.scrollController,
        children: [
          Obx(() => PageBanner(
            videoLoading: RxBool(false),
            bannerOnTap: () {  },
              mainTitleController: _viewModel.pageBannerMainTitleController,
              subtitleController: _viewModel.pageBannerSubTitleController,
              descriptionController: _viewModel.pageBannerDescriptionController,
            isNetworkVideoControllerInitialized: _viewModel.isVideoControllerInitialized.value,
            newVideo: _viewModel.newBanner,
            networkVideoController: _viewModel.isVideoControllerInitialized.value ? _viewModel.videoPlayerController.controller : null,
            formKey: _viewModel.formKey, newVideoController: VideoPlayerController.file(File('')),
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
                        newBanner: _viewModel.newBanner.value.isEmpty ? null : _viewModel.newBanner.value,
                        uploadedBanner: _viewModel.newBanner.value.isEmpty ? _viewModel.videoPlayerController.dataSource : null,
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
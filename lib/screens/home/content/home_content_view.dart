import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/home/content/home_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

class HomeContentView extends StatelessWidget {
  HomeContentView({super.key});

  final HomeContentViewModel _viewModel = Get.put(HomeContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 1,
        scrollController: _viewModel.scrollController,
        children: [
          SectionHeadingText(headingText: 'Our Mission'),
          SectionContainer(
              children: [
                CustomTextFormField(
                  title: 'Heading Text',
                  includeAsterisk: true,
                  showCounter: true,
                  maxLength: 30,
                  validator: (value) => Validators.validateEmptyField(value),
                ),
                CustomTextFormField(
                  title: 'Description',
                  includeAsterisk: true,
                  maxLength: 50,
                  maxLines: 3,
                  showCounter: true,
                  validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
                )
              ]
          ),
          SectionHeadingText(headingText: 'Secondary Banner'),
          SectionContainer(
              children: [
                // PageBanner(
                //   includeTopTitle: false,
                //     mainTitleController: _viewModel.secondaryBannerMainTitleController,
                //     subtitleController: _viewModel.secondaryBannerSubTitleController,
                //     descriptionController: _viewModel.secondaryBannerDescriptionController,
                //     newVideo: _viewModel.newImage
                // )
              ]
          )
        ]
    );
  }
}
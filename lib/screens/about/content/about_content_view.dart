import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/about/content/about_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

class AboutContentView extends StatelessWidget {
  AboutContentView({super.key});

  final AboutContentViewModel _viewModel = Get.put(AboutContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      selectedSidePanelItem: 4,
      scrollController: _viewModel.scrollController,
      children: [
        SectionHeadingText(headingText: 'Personal Details'),
        SectionContainer(
          key: _viewModel.personalDetailsFormKey,
            children: [
              CustomTextFormField(
                title: 'Name',
                includeAsterisk: true,
                controller: _viewModel.nameController,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              CustomTextFormField(
                includeAsterisk: true,
                title: 'Designation',
                controller: _viewModel.designationController,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              CustomTextFormField(
                includeAsterisk: true,
                title: 'Description',
                controller: _viewModel.pageBannerDescriptionController,
                maxLines: 10,
                maxLength: 300,
                showCounter: true,
                validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 300),
              )
            ]
        ),
        SectionHeadingText(headingText: 'Milestones & Achievements Management'),
        SectionContainer(
          formKey: _viewModel.milestoneDetailsFormKey,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      title: 'Title',
                      controller: _viewModel.milestoneTitleController,
                      validator: (value) => Validators.validateLongDescriptionText(value),
                      includeAsterisk: true,
                      showCounter: true,
                      maxLength: 25,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      title: 'Year Text',
                      controller: _viewModel.milestoneYearTextController,
                      validator: (value) => Validators.validateLongDescriptionText(value),
                      includeAsterisk: true,
                      showCounter: true,
                      maxLength: 25,
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                title: 'Description',
                maxLines: 3,
                controller: _viewModel.milestoneTitleController,
                validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
                includeAsterisk: true,
                showCounter: true,
                maxLength: 50,
              ),
            ]
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/about/content/about_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/add_image_section.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_actions_buttons.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_entry_item.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_serial_no_text.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../utils/custom_widgets/section_container.dart';
import '../../../utils/validators.dart';

class AboutContentView extends StatelessWidget {
  AboutContentView({super.key});

  final AboutContentViewModel _viewModel = Get.put(AboutContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      selectedSidePanelItem: 5,
      scrollController: _viewModel.scrollController,
      children: [
        SectionContainer(
            headingText: 'Personal Details',
            formKey: _viewModel.personalDetailsFormKey,
            height: _viewModel.personalDetailsHeight,
            children: [
              if(isSmallScreen(context)) Center(
                child: AddImageSection(
                  newImage: _viewModel.newImage,
                  width: 150,
                  height: 180,
                ),
              ),
              if(isSmallScreen(context)) CustomTextFormField(
                title: 'Name',
                includeAsterisk: true,
                controller: _viewModel.nameController,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              if(isSmallScreen(context)) CustomTextFormField(
                includeAsterisk: true,
                title: 'Designation',
                controller: _viewModel.designationController,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              if(!isSmallScreen(context)) Row(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 15,
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
                      ],
                    ),
                  ),
                  Obx(() => AddImageSection(
                      newImage: _viewModel.newImage,
                      width: 130,
                      height: 150,
                      imageUrl: "${Urls.baseURL}${_viewModel.sharedData.value.content?.leadership?.people?.first.image}",
                    ),
                  ),
                ],
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
        SectionContainer(
            headingText: 'Milestones & Achievements Management',
            formKey: _viewModel.milestoneDetailsFormKey,
            height: _viewModel.milestonesAndAchievementsHeight,
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
                      onChanged: (value) {
                        if(value.isEmpty && _viewModel.milestoneYearTextController.text.isEmpty && _viewModel.milestoneDescController.text.isEmpty) {
                          _viewModel.updatingValue.value = false;
                        }
                      },
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
                      onChanged: (value) {
                        if(value.isEmpty && _viewModel.milestoneDescController.text.isEmpty && _viewModel.milestoneTitleController.text.isEmpty) {
                          _viewModel.updatingValue.value = false;
                        }
                      },
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                title: 'Description',
                maxLines: 3,
                controller: _viewModel.milestoneDescController,
                validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 100),
                includeAsterisk: true,
                showCounter: true,
                onChanged: (value) {
                  if(value.isEmpty && _viewModel.milestoneYearTextController.text.isEmpty && _viewModel.milestoneTitleController.text.isEmpty) {
                    _viewModel.updatingValue.value = false;
                  }
                },
                maxLength: 100,
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: Obx(() => CustomMaterialButton(
                      onPressed: () {},
                    text: _viewModel.updatingValue.value ? 'Update' : 'Save',
                    width: 150,
                  ),
                ),
              )
            ]
        ),
        Obx(() => ListBaseContainer(
            expandFirstColumn: false,
              entryChildren: List.generate(_viewModel.milestonesAndAchievementsList.length, (index) {
                return Padding(
                  padding: listEntryPadding,
                  child: Row(
                    spacing: 5,
                    children: [
                      ListSerialNoText(index: index),
                      ListEntryItem(text: _viewModel.milestonesAndAchievementsList[index].title,),
                      ListEntryItem(text: _viewModel.milestonesAndAchievementsList[index].year,),
                      ListEntryItem(text: _viewModel.milestonesAndAchievementsList[index].description, maxLines: 2,),
                      ListActionsButtons(
                          includeDelete: true,
                          includeEdit: true,
                          includeView: false,
                        onEditPressed: () {
                            _viewModel.updatingValue.value = true;
                            if(_viewModel.milestonesAndAchievementsHeight.value == kSectionHeightValue) {
                              _viewModel.milestonesAndAchievementsHeight.value = null;
                            }
                            _viewModel.fillMilestoneControllers(index);
                        },
                        onDeletePressed: () {},
                      )
                    ],
                  ),
                );
              }),
              listData: _viewModel.milestonesAndAchievementsList,
              columnsNames: [
                'SN',
                'Title',
                'Year Text',
                'Description',
                'Actions',
              ],
              onRefresh: () => _viewModel.fetchAboutData(),
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/home/projects/edit_project/edit_project_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/custom_widgets/add_image_section.dart';
import '../../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../../utils/custom_widgets/heading_texts.dart';
import '../../../../utils/custom_widgets/section_container.dart';
import '../../../../utils/validators.dart';

class HomeProjectEditView extends StatelessWidget {
  HomeProjectEditView({super.key});

  final HomeProjectEditViewModel _viewModel = Get.put(HomeProjectEditViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 2,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
              formKey: _viewModel.formKey,
              headingText: 'Edit Project',
              height: _viewModel.projectFormHeight,
              children: [
                if(isSmallScreen(context)) Center(
                  child: AddImageSection(
                    imageUrl: "${Urls.baseURL}${_viewModel.projectData.value.backgroundImage}",
                    includeAsterisk: true,
                    heading: 'Icon',
                    newImage: _viewModel.projectIcon,
                    width: 150,
                    height: 180,
                  ),
                ),
                if(isSmallScreen(context)) CustomTextFormField(
                  title: 'Title',
                  includeAsterisk: true,
                  maxLength: shortTitle,
                  showCounter: true,
                  controller: _viewModel.projectMainTitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                ),
                if(isSmallScreen(context)) CustomTextFormField(
                  title: 'Description',
                  includeAsterisk: true,
                  maxLines: 1,
                  maxLength: mediumDescription,
                  showCounter: true,
                  controller: _viewModel.projectDescriptionController,
                  validator: (value) => Validators.validateLongDescriptionText(value, minLength: mediumDescription),
                ),
                if(!isSmallScreen(context)) Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 15,
                        children: [
                          CustomTextFormField(
                            title: 'Title',
                            showCounter: true,
                            maxLength: shortTitle,
                            includeAsterisk: true,
                            controller: _viewModel.projectMainTitleController,
                            validator: (value) => Validators.validateEmptyField(value),
                          ),
                          CustomTextFormField(
                            title: 'Description',
                            includeAsterisk: true,
                            maxLines: 1,
                            maxLength: mediumDescription,
                            showCounter: true,
                            controller: _viewModel.projectDescriptionController,
                            validator: (value) => Validators.validateLongDescriptionText(value, minLength: mediumDescription),
                          ),
                        ],
                      ),
                    ),
                    AddImageSection(
                      imageUrl: "${Urls.baseURL}${_viewModel.projectData.value.backgroundImage}",
                      newImage: _viewModel.projectIcon,
                      width: 130,
                      height: 150,
                      heading: 'Icon',
                      includeAsterisk: true,
                    ),
                  ],
                ),
                CustomTextFormField(
                  includeAsterisk: true,
                  title: 'CTA Text',
                  validator: (value) => Validators.validateEmptyField(value),
                  controller: _viewModel.projectCtaController,
                  showCounter: true,
                  maxLength: 15 ,
                ),
                SectionHeadingText(headingText: 'Project Metrics/Statistics'),
                Obx(() => Column(
                  spacing: 15,
                  children: List.generate(_viewModel.statisticsSection.length, (index) {
                    return InformaticsOrStatsTextFormFields(
                      includeTitle: index == 0,
                      subtitleText: 'Value',
                      headingText: 'Label',
                      showHeadingCounter: true,
                      showSubtitleCounter: true,
                      headingMaxLength: mediumMetricHeading,
                      subtitleMaxLength: mediumMetricValue,
                      onTap: () => _viewModel.statisticsSection.remove(_viewModel.statisticsSection.keys.elementAt(index)),
                      includeButton: _viewModel.statisticsSection.length != 1,
                      headingController: _viewModel.statisticsSection.keys.elementAt(index),
                      subtitleController: _viewModel.statisticsSection.values.elementAt(index),
                    );

                  }),
                ),
                ),
                IconButton(
                    onPressed: () => _viewModel.statisticsSection.addIf(_viewModel.statisticsSection.length < 3, TextEditingController(), TextEditingController()),
                    icon: Center(
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30,
                        color: primaryGrey,
                      ),
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomMaterialButton(
                          onPressed: () {},
                        text: 'Save',
                        width: 150,
                      ),
                      CustomMaterialButton(
                          onPressed: () => Get.back(),
                        text: 'Cancel',
                        width: 150,
                        buttonColor: errorRed,
                        borderColor: errorRed,
                      )
                    ],
                  ),
                )
              ]
          ),
        ]
    );
  }
}

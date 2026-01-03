import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/responsibility/projects_listing/responsibility_projects_listing_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/add_image_section.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/informatics_or_stats_text_form_fields.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_actions_buttons.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_entry_item.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_serial_no_text.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../../utils/custom_widgets/custom_material_button.dart';

class ResponsibilityProjectsListingView extends StatelessWidget {
  ResponsibilityProjectsListingView({super.key});

  final ResponsibilityProjectsListingViewModel _viewModel = Get.put(ResponsibilityProjectsListingViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 10,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
            formKey: _viewModel.projectFormKey,
            headingText: 'Add Project',
              height: _viewModel.projectFormHeight,
              children: [
                AddImageSection(
                  includeAsterisk: true,
                    includeFileInstructions: true,
                    newImage: _viewModel.projectImage,
                ),
                SizedBox(height: 10,),
                CustomTextFormField(
                  includeAsterisk: true,
                  title: 'Title',
                  controller: _viewModel.projectTitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                  maxLines: 1,
                  maxLength: 30,
                  showCounter: true,
                ),
                CustomTextFormField(
                  title: 'Subtitle',
                  includeAsterisk: true,
                  controller: _viewModel.projectSubtitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                  maxLines: 1,
                  maxLength: 20,
                  showCounter: true,
                ),
                CustomTextFormField(
                  title: 'Description',
                  controller: _viewModel.projectDescController,
                  validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 60),
                  maxLines: 3,
                  includeAsterisk: true,
                  maxLength: 60,
                  showCounter: true,
                ),
                SectionHeadingText(headingText: 'Statistics'),
                SizedBox(height: 10,),
                Column(
                  spacing: 10,
                  children: List.generate(2, (index) {
                    return InformaticsOrStatsTextFormFields(
                        includeTitle: index == 0,
                        includeButton: false,
                        showSubtitleCounter: true,
                        showHeadingCounter: true,
                        headingMaxLength: 10,
                        subtitleMaxLength: 10,
                        subtitleText: 'Value',
                        headingText: 'Label',
                        headingController: _viewModel.projectStats.keys.elementAt(index),
                        subtitleController: _viewModel.projectStats.values.elementAt(index),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                    margin: EdgeInsets.only(top: 15),
                  )
                )
              ]
          ),
          Obx(() => ListBaseContainer(
                listData: _viewModel.projects,
                expandFirstColumn: false,
                columnsNames: [
                  'SN',
                  'Title',
                  'Subtitle',
                  if(!isSmallScreen(context)) 'Description',
                  'Actions'
                ],
                onRefresh: () {},
              entryChildren: List.generate(_viewModel.projects.length, (index) {
                return Padding(
                  padding: listEntryPadding,
                  child: Row(
                    children: [
                      ListSerialNoText(index: index),
                      ListEntryItem(text: _viewModel.projects[index].title,),
                      ListEntryItem(text: _viewModel.projects[index].tag,),
                      if(!isSmallScreen(context)) ListEntryItem(text: _viewModel.projects[index].description,),
                      ListActionsButtons(
                          includeDelete: true,
                          includeEdit: true,
                          includeView: true,
                          onEditPressed: () {},
                          onDeletePressed: () {},
                          onViewPressed: () => Get.toNamed(Routes.responsibilityProjectPreview, arguments: {'projectData': _viewModel.projects[index].toJson()}),
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        ]
    );
  }
}
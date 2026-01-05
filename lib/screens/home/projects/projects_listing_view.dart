import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/home/projects/projects_listing_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/add_image_section.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_cached_network_image.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_entry_item.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../../utils/custom_widgets/list_actions_buttons.dart';
import '../../../utils/custom_widgets/list_serial_no_text.dart';

class HomeProjectsListingView extends StatelessWidget {
  HomeProjectsListingView({super.key});

  final HomeProjectsListingViewmodel _viewModel = Get.put(HomeProjectsListingViewmodel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 2,
        scrollController: _viewModel.scrollController,
        children: [
          Form(
            key: _viewModel.formKey,
            child: SectionContainer(
                headingText: 'Add Projects To Home',
                height: _viewModel.projectFormHeight,
                children: [
                  if(isSmallScreen(context)) Center(
                    child: AddImageSection(
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
                    controller: _viewModel.projectMainTitleController,
                    validator: (value) => Validators.validateEmptyField(value),
                  ),
                  if(isSmallScreen(context)) CustomTextFormField(
                    title: 'Description',
                    includeAsterisk: true,
                    maxLines: 1,
                    maxLength: 50,
                    showCounter: true,
                    controller: _viewModel.projectDescriptionController,
                    validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
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
                              includeAsterisk: true,
                              controller: _viewModel.projectMainTitleController,
                              validator: (value) => Validators.validateEmptyField(value),
                            ),
                            CustomTextFormField(
                              title: 'Description',
                              includeAsterisk: true,
                              maxLines: 1,
                              maxLength: 50,
                              showCounter: true,
                              controller: _viewModel.projectDescriptionController,
                              validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
                            ),
                          ],
                        ),
                      ),
                      AddImageSection(
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
                    controller: TextEditingController(),
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
                          headingMaxLength: 15,
                          subtitleMaxLength: 10,
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
                ]
            ),
          ),
          Obx(() => ListBaseContainer(
              expandFirstColumn: false,
                listData: _viewModel.projects,
                columnsNames: [
                  'SN',
                  'Icon',
                  'Title',
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
                      ListEntryItem(
                        child: Center(
                          child: CustomNetworkImage(
                              imageUrl: _viewModel.projects[index].icon ?? '',
                            width: isSmallScreen(context) ? 50 : 70,
                            boxFit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      ListEntryItem(text: _viewModel.projects[index].title,),
                      if(!isSmallScreen(context)) ListEntryItem(text: _viewModel.projects[index].description, maxLines: 2,),
                      ListActionsButtons(
                        includeDelete: true,
                        includeEdit: true,
                        includeView: true,
                        onDeletePressed: () {},
                        onEditPressed: () {},
                        onViewPressed: () => Get.toNamed(Routes.homeProjectPreview, arguments: {'projectData': _viewModel.projects[index].toJson()}),
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
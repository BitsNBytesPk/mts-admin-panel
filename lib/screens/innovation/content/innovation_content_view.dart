import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/innovation_data.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/add_image_section.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_actions_buttons.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_entry_item.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_serial_no_text.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/custom_widgets/section_container.dart';
import 'innovation_content_viewmodel.dart';

class InnovationContentView extends StatelessWidget {
  InnovationContentView({super.key});

  final InnovationContentViewModel _viewModel = Get.put(InnovationContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
      selectedSidePanelItem: 7,
      children: [
        SectionContainer(
          spacing: 20,
          formKey: _viewModel.formKey,
          headingText: 'Add Project',
              height: _viewModel.projectsHeight,
              children: [
                AddImageSection(
                  includeFileInstructions: true,
                    fileInstructions: 'File Format - .jpg, .png, .jpeg - Max Size - 5MB',
                    newImage: _viewModel.projectImage,
                  textAlignment: Alignment.centerLeft,
                  includeAsterisk: true,
                ),
                CustomTextFormField(
                  title: 'Title',
                  includeAsterisk: true,
                  controller: _viewModel.projectMainTitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                  maxLength: mediumTitle,
                  maxLines: 1,
                ),
                CustomTextFormField(
                  title: 'Subtitle',
                  includeAsterisk: true,
                  controller: _viewModel.projectSubtitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                  maxLength: 25,
                  maxLines: 1,
                ),
                CustomTextFormField(
                  title: 'Description',
                  includeAsterisk: true,
                  showCounter: true,
                  controller: _viewModel.projectDescController,
                  validator: (value) => Validators.validateLongDescriptionText(value, minLength: 20),
                  maxLength: mediumDescription,
                  maxLines: 3,
                ),
                SectionHeadingText(headingText: 'Informatics'),
                Obx(() => Column(
                  spacing: 15,
                    children: List.generate(_viewModel.informaticsSection.length, (index) {
                      return InformaticsOrStatsTextFormFields(
                          headingController: _viewModel.informaticsSection.keys.elementAt(index),
                          subtitleController: _viewModel.informaticsSection.values.elementAt(index),
                        includeTitle: index == 0,
                      );
                    }),
                  ),
                ),
                IconButton(
                    onPressed: () => _viewModel.informaticsSection.addIf(_viewModel.informaticsSection.length < 3, TextEditingController(), TextEditingController()),
                    icon: Center(
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30,
                        color: primaryGrey,
                      ),
                    )
                ),
                SectionHeadingText(headingText: 'Technology Section'),
                Column(
                  spacing: 15,
                  children: [
                    CustomTextFormField(
                      title: 'Section Heading',
                      includeAsterisk: true,
                      controller: _viewModel.technologySectionHeadingController,
                      validator: (value) => Validators.validateEmptyField(value),
                      maxLength: shortTitle,
                      maxLines: 1,
                    ),
                    Obx(() => Column(
                      spacing: 10,
                        children: List.generate(_viewModel.technologySection.length, (index) {
                          return InformaticsOrStatsTextFormFields(
                              includeTitle: index == 0,
                              subtitleText: 'Description',
                              headingText: 'Item Heading',
                              includeButton: _viewModel.technologySection.length != 1,
                              headingController: _viewModel.technologySection.keys.elementAt(index),
                              subtitleController: _viewModel.technologySection.values.elementAt(index),
                            onTap: () => _viewModel.technologySection.remove(_viewModel.technologySection.keys.elementAt(index)),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () => _viewModel.technologySection.addIf(_viewModel.technologySection.length < 6, TextEditingController(), TextEditingController()),
                    icon: Center(
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30,
                        color: primaryGrey,
                      ),
                    )
                ),
                SectionHeadingText(headingText: 'Application Section'),
                Column(
                  spacing: 15,
                  children: [
                    CustomTextFormField(
                      title: 'Section Heading',
                      includeAsterisk: true,
                      controller: _viewModel.applicationSectionHeadingController,
                      validator: (value) => Validators.validateEmptyField(value),
                      maxLength: shortTitle,
                      maxLines: 1,
                    ),
                    Obx(() => Column(
                      spacing: 10,
                      children: List.generate(_viewModel.applicationSection.length, (index) {
                        return InformaticsOrStatsTextFormFields(
                          includeTitle: index == 0,
                          subtitleText: 'Description',
                          headingText: 'Item Heading',
                          includeButton: _viewModel.applicationSection.length != 1,
                          headingController: _viewModel.applicationSection.keys.elementAt(index),
                          subtitleController: _viewModel.applicationSection.values.elementAt(index),
                          onTap: () => _viewModel.applicationSection.remove(_viewModel.applicationSection.keys.elementAt(index)),
                        );
                      }),
                    )),
                  ],
                ),
                IconButton(
                    onPressed: () => _viewModel.applicationSection.addIf(_viewModel.applicationSection.length < 6, TextEditingController(), TextEditingController()),
                    icon: Center(
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30,
                        color: primaryGrey,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 15,
                    children: [
                      CustomMaterialButton(
                          onPressed: () => _viewModel.navigateToPreviewScreen(),
                        text: 'Show Preview',
                        buttonColor: primaryPreviewButtonOrange,
                        borderColor: primaryPreviewButtonOrange,
                        width: 150,
                      ),
                      CustomMaterialButton(
                          onPressed: () => _viewModel.addProject(),
                        text: 'Save',
                        width: 150,
                      )
                    ],
                  ),
                )
              ]
          ),
        Obx(() => ListBaseContainer(
            listData: _viewModel.projects,
            expandFirstColumn: false,
            entryChildren: List.generate(_viewModel.projects.length, (index) {
              return Padding(
                padding: listEntryPadding,
                child: Row(
                  children: [
                    ListSerialNoText(index: index),
                    ListEntryItem(text: _viewModel.projects[index].title ?? '', maxLines: 2,),
                    ListEntryItem(text: _viewModel.projects[index].category ?? ''),
                    if(!isSmallScreen(context)) ListEntryItem(text: _viewModel.projects[index].description ?? '', maxLines: 2,),
                    ListActionsButtons(
                        includeDelete: true,
                        includeEdit: true,
                      includeView: true,
                      onViewPressed: () => Get.toNamed(Routes.innovationProjectPreview, arguments: {'projectData': _viewModel.projects[index]}),
                      onDeletePressed: () => _viewModel.deleteProject(index),
                      onEditPressed: () => Get.toNamed(Routes.innovationEditProject, arguments: {'projectData': _viewModel.projects[index], 'index': index}),
                    )
                  ],
                ),
              );
            }),
            columnsNames: [
              'SN',
              'Name',
              'Subtitle',
              if(!isSmallScreen(context)) 'Description',
              'Actions'
            ],
            onRefresh: () {},
          ),
        )
      ],
    );
  }
}
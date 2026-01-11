import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/innovation_data.dart';
import 'package:mts_website_admin_panel/screens/innovation/innovation_edit_project/innovation_edit_project_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../../../utils/constants.dart';
import '../../../utils/custom_widgets/add_image_section.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../utils/custom_widgets/heading_texts.dart';
import '../../../utils/custom_widgets/section_container.dart';
import '../../../utils/validators.dart';

class InnovationEditProjectView extends StatelessWidget {
  InnovationEditProjectView({super.key});

  final InnovationEditProjectViewModel _viewModel = Get.put(InnovationEditProjectViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 7,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
            formKey: _viewModel.formKey,
              headingText: 'Edit Project',
              height: RxnDouble(null),
              children: [
                Obx(() =>  AddImageSection(
                  height: 250,
                    fileMaxSize: 10,
                    imageUrl: "${Urls.baseURL}${_viewModel.project.value.image}",
                    includeFileInstructions: true,
                    fileInstructions: 'File Format - .jpg, .png, .jpeg - Max Size - 10MB',
                    newImage: _viewModel.projectImage,
                    textAlignment: Alignment.centerLeft,
                    includeAsterisk: true,
                  ),
                ),
                CustomTextFormField(
                  title: 'Title',
                  includeAsterisk: true,
                  controller: _viewModel.projectMainTitleController,
                  validator: (value) => Validators.validateEmptyField(value),
                  maxLength: 50,
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
                  controller: _viewModel.projectDescController,
                  validator: (value) => Validators.validateLongDescriptionText(value, minLength: 20),
                  maxLength: mediumDescription,
                  maxLines: 3,
                  showCounter: true,
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
                )),
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
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Wrap(
                      spacing: 15,
                      children: [
                        CustomMaterialButton(
                            onPressed: () {
                              if(_viewModel.projectImage.value.isNotEmpty) {
                                _viewModel.project.value.newImage = _viewModel.projectImage.value;
                              }

                              List<Metrics> metrics = [];
                              List<Items> applications = [];
                              List<Items> technology = [];

                              _viewModel.informaticsSection.forEach((key, value) {
                                metrics.add(Metrics(label: key.text, value: value.text));
                              });

                              _viewModel.technologySection.forEach((key, value) {
                                technology.add(Items(title: key.text, description: value.text));
                              });

                              _viewModel.applicationSection.forEach((key, value) {
                                applications.add(Items(title: key.text, description: value.text));
                              });

                              Get.toNamed(
                                  Routes.innovationProjectPreview,
                                  arguments: {'projectData': InnovationProjects(
                                    image: _viewModel.project.value.image,
                                    newImage: _viewModel.projectImage.value,
                                    title: _viewModel.projectMainTitleController.text,
                                    category: _viewModel.projectSubtitleController.text,
                                    description: _viewModel.projectDescController.text,
                                    metrics: metrics,
                                    technology: ApplicationsOrTechnology(
                                        heading: _viewModel.technologySectionHeadingController.text,
                                        items: technology
                                    ),
                                    applications: ApplicationsOrTechnology(
                                      heading: _viewModel.applicationSectionHeadingController.text,
                                      items: applications,
                                    ),
                                  )
                              });
                            },
                            text: 'Show Preview',
                            buttonColor: primaryPreviewButtonOrange,
                            borderColor: primaryPreviewButtonOrange,
                            width: 150,
                        ),
                        CustomMaterialButton(
                            onPressed: () => _viewModel.updateProject(),
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
                  ),
                )
              ]
          ),
        ]
    );
  }
}
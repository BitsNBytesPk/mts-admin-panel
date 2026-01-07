
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/add_image_section.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_actions_buttons.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_entry_item.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_serial_no_text.dart';
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
          headingText: 'Add Project',
              height: _viewModel.projectsHeight,
              children: [
                AddImageSection(
                  includeFileInstructions: true,
                    fileInstructions: 'File Format - .jpg, .png, .jpeg - Max Size - 3MB',
                    newImage: _viewModel.projectImage,
                  textAlignment: Alignment.centerLeft,
                  includeAsterisk: true,
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
                  validator: (value) => Validators.validateLongDescriptionText(value, minLength: 50),
                  maxLength: 50,
                  maxLines: 3,
                ),
                SectionHeadingText(headingText: 'Informatics'),
                InformaticsOrStatsTextFormFields(
                    headingController: _viewModel.firstHeadingController,
                    subtitleController: _viewModel.firstInformaticsSubtitleController,
                  includeTitle: true,
                ),
                InformaticsOrStatsTextFormFields(
                    headingController: _viewModel.secondHeadingController,
                    subtitleController: _viewModel.secondInformaticsSubtitleController,
                ),
                InformaticsOrStatsTextFormFields(
                    headingController: _viewModel.thirdHeadingController,
                    subtitleController: _viewModel.thirdInformaticsSubtitleController,
                ),
                SectionHeadingText(headingText: 'Technology Section'),
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
                // Text('Add on Home', style: Theme.of(context).textTheme.bodySmall,),
                // Obx(() => CustomSwitch(
                //       onChanged: (value) => _viewModel.includeInHome.value = value, switchValue: _viewModel.includeInHome.value,
                //   ),
                // ),
                // Obx(() => Visibility(
                //     visible: _viewModel.includeInHome.value,
                //     child: Column(
                //         spacing: 10,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           SectionHeadingText(headingText: 'Statistics',),
                //           Column(
                //             spacing: 10,
                //             children: List.generate(_viewModel.statisticsSection.length, (index) {
                //               return InformaticsTextFieldRow(
                //                 includeTitle: index == 0,
                //                 subtitleText: 'Value',
                //                 includeButton: _viewModel.statisticsSection.length != 1,
                //                 onTap: () => _viewModel.statisticsSection.remove(_viewModel.statisticsSection.keys.elementAt(index)),
                //                 headingController: _viewModel.statisticsSection.keys.elementAt(index),
                //                 subtitleController: _viewModel.statisticsSection.values.elementAt(index),
                //               );
                //             }),
                //           ),
                //           IconButton(
                //               onPressed: () => _viewModel.statisticsSection.addIf(_viewModel.statisticsSection.length < 3, TextEditingController(), TextEditingController()),
                //               icon: Center(
                //                 child: Icon(
                //                   Icons.add_circle_outline_outlined,
                //                   size: 30,
                //                   color: primaryGrey,
                //                 ),
                //               )
                //           ),
                //         ],
                //       )
                //   ),
                // )
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
                    ListEntryItem(text: _viewModel.projects[index].title,),
                    ListEntryItem(text: _viewModel.projects[index].category),
                    ListEntryItem(text: 'Yes'),
                    ListActionsButtons(
                        includeDelete: true,
                        includeEdit: true,
                      includeView: false,
                      onDeletePressed: () {},
                      onEditPressed: () {},
                    )
                  ],
                ),
              );
            }),
            columnsNames: [
              'SN',
              'Name',
              'Subtitle',
              'Added To Home',
              'Actions'
            ],
            onRefresh: () {},
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_switch.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_actions_buttons.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;

import '../../utils/custom_widgets/list_entry_item.dart';
import '../../utils/custom_widgets/project_setup_section.dart';
import 'about_viewmodel.dart';

class AboutView extends StatelessWidget {
  AboutView({super.key});

  final AboutViewModel _viewModel = Get.put(AboutViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 2,
        children: [
          // PageBanner(
          //   newVideo: _viewModel.projectImage,
          //   mainTitleController: _viewModel.pageBannerMainTitleController,
          //   subtitleController: _viewModel.pageBannerSubTitleController,
          //   descriptionController: _viewModel.pageBannerDescriptionController,
          //   videoController: _viewModel.,
          //   videoPlayerFuture: null,
          // ),
          ProjectSetupSection(
              projectType: _viewModel.projectType,
            enableAutoValidation: _viewModel.enableAutoValidation.value,
              techStackList: _viewModel.techStack,
              keyFeaturesList: _viewModel.keyFeatures,
              projectColor: _viewModel.projectColor,
              formKey: _viewModel.projectFormKey,
              projectNameController: _viewModel.projectNameController,
              projectDescController: _viewModel.projectDescController,
              onBtnPressed: () => _viewModel.addNewProject(),
              projectStatus: _viewModel.projectStatus,
              projectImage: _viewModel.projectImage,
              projectIosLinkController: _viewModel.projectIosLinkController,
              projectAndroidLinkController: _viewModel.projectAndroidLinkController,
              projectGithubLinkController: _viewModel.projectGithubLinkController
          ),
          PageHeadingText(headingText: lang_key.projectList.tr),
          Obx(() => ListBaseContainer(
            onRefresh: () => _viewModel.getAllProjects(),
              hintText: lang_key.searchProject.tr,
              controller: _viewModel.projectSearchController,
              listData: _viewModel.visibleProjectsList,
              expandFirstColumn: false,
              onSearch: (value) => _viewModel.searchInList(_viewModel.projectSearchController.text),
              columnsNames: [
                lang_key.sl.tr,
                lang_key.projectName.tr,
                lang_key.projectStatus.tr,
                lang_key.show.tr,
                lang_key.actions.tr
              ],
              entryChildren: List.generate(_viewModel.visibleProjectsList.length, (index) {
                return Padding(
                  padding: listEntryPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListEntryItem(text: (index + 1).toString(), shouldExpand: false,),
                        ListEntryItem(text: _viewModel.visibleProjectsList[index].name),
                        ListEntryItem(text: switch (_viewModel.visibleProjectsList[index].projectStatus) {
                          'Under Development' || null => lang_key.underDevelopment.tr,
                          'Completed' => lang_key.completed.tr,
                          String() => lang_key.underDevelopment.tr,
                        },),
                        ListEntryItem(
                          child: CustomSwitch(
                            switchValue: _viewModel.visibleProjectsList[index].status!,
                            onChanged: (value) => _viewModel.changeProjectStatus(_viewModel.visibleProjectsList[index].id!),
                        ),),
                        ListActionsButtons(
                          includeDelete: true,
                          includeEdit: true,
                          includeView: false,
                          onDeletePressed: () => _viewModel.deleteProject(index),
                          // onEditPressed: () => Get.toNamed(Routes.innovation, arguments: {projectDetailsKey: _viewModel.visibleProjectsList[index]}),
                        )
                      ]
                  ),
                );
              }),
            ),
          )
        ],
    );
  }
}
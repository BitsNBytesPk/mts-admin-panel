import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;
import 'package:mts_website_admin_panel/utils/routes.dart';

import '../../utils/constants.dart';
import '../../utils/custom_widgets/custom_switch.dart';
import '../../utils/custom_widgets/list_actions_buttons.dart';
import '../../utils/custom_widgets/list_base_container.dart';
import '../../utils/custom_widgets/list_entry_item.dart';
import '../../utils/custom_widgets/list_serial_no_text.dart';
import '../../utils/custom_widgets/screens_base_widget.dart';
import '../../utils/custom_widgets/heading_texts.dart';
import 'contact_viewmodel.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});

  final ContactViewModel _viewModel = Get.put(ContactViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 5,
        children: [
          PageHeadingText(headingText: lang_key.packagesManagement.tr),
          Container(
            decoration: kContainerBoxDecoration,
            padding: EdgeInsets.all(15),
            // child: PackageForm(
            //     packageNameController: _viewModel.packageNameController,
            //     packageMainDescController: _viewModel.packageMainDescController,
            //     packageSecDescController: _viewModel.packageSecDescController,
            //     packageDownloadsController: _viewModel.packageDownloadsController,
            //     packagePubPointsController: _viewModel.packagePubPointsController,
            //     packageGithubController: _viewModel.packageGithubController,
            //     packagePackageManagerController: _viewModel.packagePackageManagerController,
            //     packageLikesController: _viewModel.packageLikesController,
            //     packageVersionController: _viewModel.packageVersionController,
            //     formKey: _viewModel.formKey,
            //     keyFeaturesList: _viewModel.keyFeaturesList,
            //     techStackList: _viewModel.techStackList,
            //     onContBtnPressed: () => _viewModel.addPackage(),
            //     packageImageOrGif: _viewModel.packageImageOrGif
            // )
          ),
          PageHeadingText(headingText: 'Packages List'),
          _AllPackages(),
        ]
    );
  }
}

/// All Packages Listing
class _AllPackages extends StatelessWidget {
  _AllPackages();

  final ContactViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListBaseContainer(
        onRefresh: () => _viewModel.fetchAllPackages(),
        onSearch: (value) => _viewModel.searchList(value, _viewModel.allPackagesList, _viewModel.visiblePackagesList),
        expandFirstColumn: false,
        hintText: lang_key.searchPackage.tr,
          controller: _viewModel.allOrderSearchController,
          listData: _viewModel.visiblePackagesList,
        columnsNames: [
          lang_key.sl.tr,
          lang_key.name.tr,
          'Downloads',
          'Version',
          'Likes',
          lang_key.status.tr,
          lang_key.actions.tr
        ],
        entryChildren: List.generate(_viewModel.visiblePackagesList.length, (index) {
          return Padding(
            padding: listEntryPadding.copyWith(bottom: 8),
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListSerialNoText(index: index),
                ListEntryItem(text: _viewModel.visiblePackagesList[index].name!, maxLines: 1,),
                ListEntryItem(text: _viewModel.visiblePackagesList[index].downloads.toString()),
                ListEntryItem(text: _viewModel.visiblePackagesList[index].version ?? ''),
                ListEntryItem(text: _viewModel.visiblePackagesList[index].likes.toString()),
                ListEntryItem(
                  child: CustomSwitch(switchValue: _viewModel.visiblePackagesList[index].status!,
                      onChanged: (value) {}
                  ),
                ),
                ListActionsButtons(
                    includeDelete: true,
                    includeEdit: true,
                    includeView: false,
                  onDeletePressed: () => _viewModel.deletePackage(index),
                  onEditPressed: () => Get.toNamed(
                      Routes.editPackage,
                      arguments: {packageDetailsKey: _viewModel.visiblePackagesList[index]}
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
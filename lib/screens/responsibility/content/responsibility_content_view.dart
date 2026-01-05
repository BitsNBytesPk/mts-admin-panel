import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/responsibility/content/responsibility_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';

import '../../../utils/custom_widgets/custom_text_form_field.dart';

class ResponsibilityContentView extends StatelessWidget {
  ResponsibilityContentView({super.key});

  final ResponsibilityContentViewModel _viewModel = Get.put(ResponsibilityContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 9,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
            headingText: 'Our Commitment Stats',
              height: _viewModel.ourCommitmentHeight,
              formKey: _viewModel.ourCommitmentFormKey,
              children: [
                Obx(() => Column(
                  spacing: 10,
                  children: List.generate(_viewModel.ourCommitmentControllers.length, (index) {
                    return SingleStatTextAndTextFormField(
                      includeHeading: index == 0,
                      label: _viewModel.responsibilityData.value.content?.commitment?.stats?[index].label ?? '',
                      controller: _viewModel.ourCommitmentControllers[index],
                    );
                  }),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    margin: EdgeInsets.only(top: 15),
                      onPressed: () {},
                    text: 'Save',
                    width: 150,
                  ),
                )
              ]
          ),
          SectionContainer(
            headingText: 'Collaboration Stats',
              height: _viewModel.collaborationHeight,
              formKey: _viewModel.collaborationFormKey,
              children: [
                Obx(() => Column(
                  spacing: 10,
                  children: List.generate(_viewModel.collaborationControllers.length, (index) {
                    return SingleStatTextAndTextFormField(
                      includeHeading: index == 0,
                      label: _viewModel.responsibilityData.value.content?.partnerships?.cards?[index].title ?? '',
                      controller: _viewModel.collaborationControllers[index],
                    );
                  }),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    margin: EdgeInsets.only(top: 15),
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                  ),
                )
              ]
          ),
          SectionContainer(
            headingText: 'Impact Dashboard Stats',
              height: _viewModel.impactDashboardHeight,
              formKey: _viewModel.impactDashboardFormKey,
              children: [
                Obx(() => Column(
                  spacing: 10,
                  children: List.generate(_viewModel.impactDashboardControllers.length, (index) {
                    return SingleStatTextAndTextFormField(
                      includeHeading: index == 0,
                      label: _viewModel.responsibilityData.value.content?.impact?.metrics?[index].label ?? '',
                      controller: _viewModel.impactDashboardControllers[index],
                    );
                  }),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    margin: EdgeInsets.only(top: 15),
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                  ),
                )
              ]
          )
        ]
    );
  }
}
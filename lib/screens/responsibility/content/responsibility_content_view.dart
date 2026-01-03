import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/responsibility/content/responsibility_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

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
                    return _OurCommitmentSingleStat(
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
                    return _OurCommitmentSingleStat(
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
                    return _OurCommitmentSingleStat(
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

class _OurCommitmentSingleStat extends StatelessWidget {
  const _OurCommitmentSingleStat({required this.label, required this.controller, this.includeHeading = false});

  final String label;
  final TextEditingController controller;
  final bool includeHeading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!includeHeading) SizedBox(height: 0.5,),
              if(includeHeading) Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Label',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Expanded(
          flex: isSmallScreen(context) ? 3 : 4,
          child: CustomTextFormField(
            title: includeHeading ? 'Stat' : null,
            includeAsterisk: includeHeading,
            controller: controller,
            maxLength: 5,
            showCounter: true,
            maxLines: 1,
            minLines: 1,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        )
      ],
    );
  }
}


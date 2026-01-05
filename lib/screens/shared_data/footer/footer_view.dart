import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/shared_data/footer/footer_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../../utils/constants.dart';

class FooterView extends StatelessWidget {
  FooterView({super.key});

  final FooterViewModel _viewModel = Get.put(FooterViewModel());

  @override
  Widget build(BuildContext context) {

    return ScreensBaseWidget(
        selectedSidePanelItem: 13,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
            formKey: _viewModel.footerBasicDataFormKey,
            headingText: 'Footer Basic Data',
              height: _viewModel.basicDataFormHeight,
              children: [
                CustomTextFormField(
                  title: 'Brand Statement',
                  includeAsterisk: true,
                  controller: _viewModel.brandStatementController,
                  maxLength: 80,
                  maxLines: 3,
                  minLines: 1,
                  showCounter: true,
                  validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 80),
                ),
                CustomTextFormField(
                  title: 'Copyrights Text',
                  includeAsterisk: true,
                  controller: _viewModel.copyRightsController,
                  maxLength: 80,
                  showCounter: true,
                  maxLines: 3,
                  minLines: 1,
                  validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 80),
                ),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: CustomMaterialButton(
                    margin: EdgeInsets.only(top: 15),
                      onPressed: () {},
                    text: 'Save',
                    width: 150,
                  ),
                )
              ]
          ),
          Obx(() => SectionContainer(
            formKey: _viewModel.socialLinksFormKey,
              headingText: 'Social Links',
                height: _viewModel.socialLinksFormHeight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      spacing: 15,
                      children: List.generate(_viewModel.socialLinks.length, (index) {

                        return InformaticsOrStatsTextFormFields(
                          includeTitle: index == 0,
                          onTap: () => _viewModel.socialLinks.remove(_viewModel.socialLinks.keys.elementAt(index)),
                          headingController: _viewModel.socialLinks.keys.elementAt(index),
                          subtitleController: _viewModel.socialLinks.values.elementAt(index),
                          headingText: 'Label',
                          subtitleText: 'Link',
                          includeButton: true,
                          // includeAsterisk: true,
                        );
                      }),
                    ),
                  ),
                  Center(
                    child: IconButton(
                        onPressed: () {
                          if(_viewModel.socialLinks.length < 3) {
                            _viewModel.socialLinks.addAllIf(_viewModel.socialLinks.length < 3, {TextEditingController(): TextEditingController()});
                          }
                        },
                        icon: Icon(
                          Icons.add_circle_outline_rounded,
                          size: 30,
                          color: primaryGrey,
                        )
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: CustomMaterialButton(
                      onPressed: () {},
                      text: 'Save',
                      width: 150,
                      margin: EdgeInsets.only(top: 15),
                    ),
                  )
                ]
            ),
          ),

        ]
    );
  }
}

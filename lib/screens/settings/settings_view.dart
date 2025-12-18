import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/screens/settings/settings_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_text_form_field.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';
import 'package:mts_website_admin_panel/utils/images_paths.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../helpers/pick_single_image.dart';
import '../../languages/translation_keys.dart' as lang_key;
import '../../utils/custom_widgets/custom_cached_network_image.dart';
import '../../utils/custom_widgets/overlay_icon.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingsViewModel _viewModel = Get.put(SettingsViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 8,
        scrollController: _viewModel.scrollController,
        children: [
          PageHeadingText(headingText: 'Settings'),
          Container(
            padding: EdgeInsets.all(20),
            decoration: kContainerBoxDecoration,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      _ProfileImage(),
                      _CvField(),
                    ],
                  )
                ],
              )
          ),
          Form(
            key: _viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                PageHeadingText(headingText: 'Social Links'),
                _SocialLinksFields(),
                PageHeadingText(headingText: 'Personal Details'),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: kContainerBoxDecoration,
                  width: double.infinity,
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              title: lang_key.name.tr,
                              includeAsterisk: true,
                              controller: _viewModel.nameController,
                              validator: (value) => Validators.validateEmptyField(value),
                              maxLines: 1,
                              hint: 'Wajeeh Ahsan',
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              title: 'Professional Title',
                              hint: 'Flutter Developer',
                              includeAsterisk: true,
                              controller: _viewModel.titleController,
                              validator: (value) => Validators.validateEmptyField(value),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        title: 'About Me',
                        controller: _viewModel.aboutMeController,
                        includeAsterisk: true,
                        maxLines: 5,
                        validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
                        hint: 'Write a small intro',
                      ),
                      CustomTextFormField(
                        title: 'About Me Secondary Description',
                        controller: _viewModel.aboutMeSecondaryDescController,
                        includeAsterisk: true,
                        maxLines: 5,
                        validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 50),
                        hint: 'Write a few more details',
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              title: lang_key.email.tr,
                              controller: _viewModel.emailController,
                              includeAsterisk: true,
                              maxLines: 1,
                              validator: (value) => Validators.validateEmail(value),
                              hint: 'abc@example.com',
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              title: 'Copyrights Text',
                              controller: _viewModel.copyrightsTextController,
                              includeAsterisk: true,
                              maxLines: 1,
                              validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 15),
                              hint: 'All rights reserved',
                            ),
                          )
                        ],
                      ),
                      CustomTextFormField(
                        title: 'Footer Text',
                        controller: _viewModel.footerDescController,
                        includeAsterisk: true,
                        maxLines: 1,
                        validator: (value) => Validators.validateEmptyField(value),
                      ),
                      CustomTextFormField(
                        title: 'Summary Text',
                        controller: _viewModel.summaryTextController,
                        includeAsterisk: true,
                        maxLines: 1,
                        validator: (value) => Validators.validateEmptyField(value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomMaterialButton(
              onPressed: () => _viewModel.updateDetails(),
              text: lang_key.save.tr,
              width: 150,
            ),
          )
        ]
    );
  }
}

class _ProfileImage extends StatelessWidget {
  _ProfileImage();

  final SettingsViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DottedBorder(
          options: RectDottedBorderOptions(
            dashPattern: [14,14],
            strokeWidth: 1.5,
            color: primaryGrey,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => pickSingleImage(imageToUpload: _viewModel.newPortfolioImage),
                  child: Obx(() => _viewModel.newPortfolioImage.value.isNotEmpty && _viewModel.newPortfolioImage.value != Uint8List(0) ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.memory(_viewModel.newPortfolioImage.value, fit: BoxFit.fitHeight,),
                      OverlayIcon(iconData: Icons.close, top: 5, right: 5, onPressed: () => _viewModel.newPortfolioImage.value = Uint8List(0),),
                    ],
                  ) : _viewModel.portfolioGeneralData.value.displayImage == null ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagesPaths.uploadFile),
                      Text(
                        lang_key.uploadFile.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: primaryGrey50
                        ),
                      )
                    ],
                  ) : CustomNetworkImage(
                    imageUrl: _viewModel.portfolioImageLink.value,
                    boxFit: BoxFit.fitHeight,
                  ),
                )
            ),
          )
      ),
    )
    );
  }
}

class _CvField extends StatelessWidget {
  _CvField();

  final SettingsViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => Column(
          spacing: 10,
          children: [
            DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [14,14],
                strokeWidth: 1.5,
                color: primaryGrey,
              ),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: InkWell(
                  onTap: () => _viewModel.pickCvFile(),
                  child: Obx(() => _viewModel.newCvFile.value.isNotEmpty && _viewModel.newCvFile.value != Uint8List(0) ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(ImagesPaths.pdf, fit: BoxFit.fitHeight,),
                      OverlayIcon(
                          iconData: Icons.close,
                          top: 5,
                          right: 5,
                          onPressed: () {
                            _viewModel.newCvFile.value = Uint8List(0);
                            _viewModel.cvFileName.value = _viewModel.portfolioGeneralData.value.cvLink!.split('/o/')[1].split('?')[0];
                          }),
                    ],
                  ) : _viewModel.cvFileName.value.isEmpty ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagesPaths.uploadFile),
                      Text(
                        lang_key.uploadFile.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: primaryGrey50
                        ),
                      )
                    ],
                  ) : Image.asset(
                    ImagesPaths.pdf,
                    fit: BoxFit.fitHeight,
                  ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _viewModel.cvFileName.value == '' || _viewModel.cvFileName.value.isEmpty ? Colors.transparent : primaryGrey50
              ),
              child: Row(
                spacing: 5,
                children: [
                  Expanded(
                    child: Text(
                      _viewModel.cvFileName.value,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  if(_viewModel.cvFileName.value.isNotEmpty && _viewModel.cvFileName.value != '') GestureDetector(
                    onTap: () => _viewModel.downloadCv(),
                    child: Icon(
                      Icons.file_download_outlined,
                      color: primaryBlack,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SocialLinksFields extends StatelessWidget {
  _SocialLinksFields();

  final SettingsViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: kContainerBoxDecoration,
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: CustomTextFormField(
              includeAsterisk: true,
              title: 'Github Profile Link',
              controller: _viewModel.githubLinkController,
              validator: (value) => Validators.validateEmptyField(value),
            ),
          ),
          Expanded(
            child: CustomTextFormField(
              includeAsterisk: true,
              title: 'LinkedIn Profile Link',
              controller: _viewModel.linkedinLinkController,
              validator: (value) => Validators.validateEmptyField(value),
            ),
          ),
        ],
      ),
    );
  }
}

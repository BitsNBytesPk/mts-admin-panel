import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import '../constants.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;

import '../validators.dart';
import 'add_image_section.dart';
import 'custom_material_button.dart';
import 'custom_text_form_field.dart';
import 'features_text_form_field.dart';

class ProjectSetupSection extends StatelessWidget {
  const ProjectSetupSection({
    super.key,
    required this.formKey,
    required this.projectNameController,
    required this.projectDescController,
    required this.onBtnPressed,
    required this.projectStatus,
    required this.projectType,
    required this.projectImage,
    required this.projectIosLinkController,
    required this.projectAndroidLinkController,
    required this.projectGithubLinkController,
    required this.projectColor,
    required this.techStackList,
    required this.keyFeaturesList,
    this.isBeingEdited = false,
    this.enableAutoValidation = true,
    this.includeCancelBtn = false,
    this.onCancelBtnPressed,
    this.imageUrl
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController projectNameController;
  final TextEditingController projectDescController;
  final TextEditingController projectIosLinkController;
  final TextEditingController projectAndroidLinkController;
  final TextEditingController projectGithubLinkController;
  final RxString projectStatus;
  final RxString projectType;
  final Rx<Uint8List> projectImage;
  final bool isBeingEdited;
  final VoidCallback onBtnPressed;
  final VoidCallback? onCancelBtnPressed;
  final bool enableAutoValidation;
  final bool includeCancelBtn;
  final Rx<Color> projectColor;
  final RxList<String> techStackList;
  final RxList<String> keyFeaturesList;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: kContainerBoxDecoration,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            _ProjectNameDescAndImage(
                projectNameController: projectNameController,
                projectDescController: projectDescController,
                projectImage: projectImage,
              isBeingEdited: isBeingEdited,
              imageUrl: imageUrl,
            ),
            Obx(() => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: MediaQuery.sizeOf(context).width < 750 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: _projectStatusChildren(),
                ) : Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.start,
                  spacing: 15,
                  children: _projectStatusChildren()
                ),
              ),
            ),
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: MediaQuery.sizeOf(context).width < 750 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: _projectTypeChildren(),
              ) : Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.start,
                  spacing: 15,
                  children: _projectTypeChildren()
              ),
            ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    prefixIcon: Icon(CupertinoIcons.link, size: 17),
                    title: 'App Store Link',
                    controller: projectIosLinkController,
                    hint: 'https://apps.apple.com/us/app/name/id000000',
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    prefixIcon: Icon(CupertinoIcons.link, size: 17,),
                    title: 'Google Play Link',
                    controller: projectAndroidLinkController,
                    hint: 'https://play.google.com/store/apps/details?id=com.example.app',
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    prefixIcon: Icon(CupertinoIcons.link, size: 17),
                    title: 'Github Repo Link',
                    controller: projectGithubLinkController,
                    hint: 'https://github.com/Wajeeh007/repository.git',
                  ),
                ),
                _ProjectColorPickerField(projectColor: projectColor),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Expanded(
                  child: TechStackOrKeyFeaturesField(
                      title: 'Key Features',
                      list: keyFeaturesList,
                    maxChars: 20,
                  ),
                ),
                Expanded(
                  child: TechStackOrKeyFeaturesField(
                      title: 'Tech Stack',
                      list: techStackList,
                    maxChars: 15,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(includeCancelBtn) CustomMaterialButton(
                  onPressed: onCancelBtnPressed!,
                  text: lang_key.cancel.tr,
                  buttonColor: errorRed,
                  borderColor: errorRed,
                  width: 200,
                ),
                CustomMaterialButton(
                  width: 200,
                    onPressed: onBtnPressed,
                  text: lang_key.cont.tr,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _projectStatusChildren() {
    return [
      Text(
        'Project Status: ',
        style: Theme.of(Get.context!).textTheme.bodyMedium,
      ),
      Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: lang_key.underDevelopment.tr,
            groupValue: projectStatus.value,
            onChanged: (value) => projectStatus.value = value!,
          ),
          Text(
            lang_key.underDevelopment.tr,
            style: Theme.of(Get.context!).textTheme.bodySmall,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: lang_key.completed.tr,
            groupValue: projectStatus.value,
            onChanged: (value) => projectStatus.value = value!,
          ),
          Text(
            lang_key.completed.tr,
            style: Theme.of(Get.context!).textTheme.bodySmall,
          ),
        ],
      )
    ];
  }

  List<Widget> _projectTypeChildren() {
    return [
      Text(
        'Project Type: ',
        style: Theme.of(Get.context!).textTheme.bodyMedium,
      ),
      Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'Mobile',
            groupValue: projectType.value,
            onChanged: (value) => projectType.value = value!,
          ),
          Text(
            'Mobile',
            style: Theme.of(Get.context!).textTheme.bodySmall,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'Web',
            groupValue: projectType.value,
            onChanged: (value) => projectType.value = value!,
          ),
          Text(
            'Web',
            style: Theme.of(Get.context!).textTheme.bodySmall,
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: 'Desktop',
            groupValue: projectType.value,
            onChanged: (value) => projectType.value = value!,
          ),
          Text(
            'Desktop',
            style: Theme.of(Get.context!).textTheme.bodySmall,
          ),
        ],
      ),
    ];
  }
}

/// Project name, description and image section
class _ProjectNameDescAndImage extends StatelessWidget {
  const _ProjectNameDescAndImage({
    required this.projectNameController,
    required this.projectDescController,
    required this.projectImage,
    required this.isBeingEdited,
    this.imageUrl
  }) : assert((isBeingEdited && imageUrl != null) || (isBeingEdited == false && imageUrl == null));

  final TextEditingController projectNameController;
  final TextEditingController projectDescController;
  final Rx<Uint8List> projectImage;
  final bool isBeingEdited;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            spacing: 10,
            children: [
              CustomTextFormField(
                hint: 'Cab App',
                title: lang_key.name.tr,
                includeAsterisk: true,
                validator: (value) => Validators.validateEmptyField(value),
                controller: projectNameController,
              ),
              CustomTextFormField(
                maxLines: 8,
                hint: 'Enter brief description...',
                includeAsterisk: true,
                title: lang_key.description.tr,
                validator: (value) => Validators.validateLongDescriptionText(value),
                controller: projectDescController,
              )
            ],
          ),
        ),
        AddImageSection(
          isBeingEdited: isBeingEdited,
          newImage: projectImage,
          imageUrl: imageUrl,
        )
      ],
    );
  }
}

/// Color picker field
class _ProjectColorPickerField extends StatelessWidget {
  const _ProjectColorPickerField({required this.projectColor});

  final Rx<Color> projectColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          RichText(
            text: TextSpan(
                text: 'Pick Color',
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: ' *',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: errorRed,
                    ),
                  ),
                ]
            ),
          ),
          Obx(() => ColorIndicator(
            width: MediaQuery.sizeOf(context).width < 750 ? 44 : MediaQuery.sizeOf(context).width * 0.12,
            height: 44,
            color: projectColor.value,
            onSelectFocus: false,
            onSelect: () {

              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Pick Color', textAlign: TextAlign.center,),
                      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorPicker(
                            onColorChanged: (color) {
                              projectColor.value = color;
                            },
                            pickersEnabled: <ColorPickerType, bool> {
                              ColorPickerType.accent: true,
                              ColorPickerType.primary: true,
                              ColorPickerType.wheel: true,
                              ColorPickerType.custom: true
                            },
                          ),
                        ],
                      ),
                      actions: [
                        CustomMaterialButton(
                          onPressed: () => Get.back(),
                          text: lang_key.cont.tr,
                        )
                      ],
                    );
                  }
              );

            },
          ),
          ),
        ],
      ),
    );
  }
}
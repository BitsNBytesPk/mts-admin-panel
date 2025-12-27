import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';

import '../../languages/translation_keys.dart' as lang_key;
import '../constants.dart';
import '../validators.dart';
import 'add_image_section.dart';
import 'custom_text_form_field.dart';
import 'features_text_form_field.dart';

class PackageForm extends StatelessWidget {
  const PackageForm({
    super.key,
    required this.packageNameController,
    required this.packageMainDescController,
    required this.packageSecDescController,
    required this.packageDownloadsController,
    required this.packagePubPointsController,
    required this.packageGithubController,
    required this.packagePackageManagerController,
    required this.packageLikesController,
    required this.packageVersionController,
    required this.formKey,
    required this.keyFeaturesList,
    required this.techStackList,
    required this.onContBtnPressed,
    required this.packageImageOrGif,
    this.isBeingEdited = false,
    this.onCancelBtnPressed,
    this.imageUrl
  }) : assert((isBeingEdited && onCancelBtnPressed != null) || (!isBeingEdited && onCancelBtnPressed == null));

  final TextEditingController packageNameController;
  final TextEditingController packageMainDescController;
  final TextEditingController packageSecDescController;
  final TextEditingController packageDownloadsController;
  final TextEditingController packagePubPointsController;
  final TextEditingController packageGithubController;
  final TextEditingController packagePackageManagerController;
  final TextEditingController packageLikesController;
  final TextEditingController packageVersionController;
  final GlobalKey<FormState> formKey;
  final RxList<String> keyFeaturesList;
  final RxList<String> techStackList;
  final VoidCallback onContBtnPressed;
  final VoidCallback? onCancelBtnPressed;
  final Rx<Uint8List> packageImageOrGif;
  final bool isBeingEdited;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 10,
        children: [
          _NameDescAndImage(
              packageNameController: packageNameController,
              packageMainDescController: packageMainDescController,
              packageImageOrGif: packageImageOrGif,
            isBeingEdited: isBeingEdited,
            imageUrl: imageUrl,
          ),
          CustomTextFormField(
            title: 'Secondary Description',
            controller: packageSecDescController,
            validator: (value) => Validators.validateLongDescriptionText(value),
            maxLines: 3,
            hint: 'Write use or purpose of this package here',
          ),
          _DownloadsAndPubPointsFields(
              packageDownloadsController: packageDownloadsController,
              packagePubPointsController: packagePubPointsController
          ),
          _RepoAndPackageManagerLinkFields(
              packageGithubController: packageGithubController,
              packagePackageManagerController: packagePackageManagerController
          ),
          _LikesAndVersionFields(
              packageLikesController: packageLikesController,
              packageVersionController: packageVersionController
          ),
          _KeyFeaturesAndTechStackFields(
              keyFeaturesList: keyFeaturesList,
              techStackList: techStackList
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              if(isBeingEdited) CustomMaterialButton(
                onPressed: onCancelBtnPressed!,
                text: lang_key.cancel.tr,
                width: 200,
                buttonColor: errorRed,
                borderColor: errorRed,
              ),
              CustomMaterialButton(
                  onPressed: onContBtnPressed,
                text: lang_key.cont.tr,
                width: 200,
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// Package name, main description and image or GIF of package.
class _NameDescAndImage extends StatelessWidget {
  const _NameDescAndImage({
    required this.packageNameController,
    required this.packageMainDescController,
    required this.packageImageOrGif,
    required this.isBeingEdited,
    this.imageUrl
  });

  final TextEditingController packageNameController;
  final TextEditingController packageMainDescController;
  final Rx<Uint8List> packageImageOrGif;
  final bool isBeingEdited;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              CustomTextFormField(
                controller: packageNameController,
                hint: 'google_maps_polygon',
                title: lang_key.name.tr,
                includeAsterisk: true,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              CustomTextFormField(
                controller: packageMainDescController,
                includeAsterisk: true,
                title: 'Main Description',
                validator: (value) => Validators.validateLongDescriptionText(value),
                maxLines: 6,
                hint: 'Write package main description here',
              ),
            ],
          ),
        ),
        AddImageSection(
          imageUrl: imageUrl,
          newImage: packageImageOrGif,
          fileInstructions: 'File Format - jpg, jpeg, png or gif',
        )
      ],
    );
  }
}

/// Package total downloads, and pub points (for Pub.dev) text form fields
class _DownloadsAndPubPointsFields extends StatelessWidget {
  const _DownloadsAndPubPointsFields({
    required this.packageDownloadsController,
    required this.packagePubPointsController
  });

  final TextEditingController packageDownloadsController;
  final TextEditingController packagePubPointsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: packageDownloadsController,
            hint: 'e.g; 1,518',
            includeAsterisk: true,
            title: 'Downloads',
            validator: (value) => Validators.validateEmptyField(value),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 8,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: packagePubPointsController,
            hint: 'Pub points',
            title: 'Points',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
          ),
        ),
      ],
    );
  }
}


/// Github repo and Package manager, where package is published link text form 
/// fields
class _RepoAndPackageManagerLinkFields extends StatelessWidget {
  const _RepoAndPackageManagerLinkFields({
    required this.packageGithubController,
    required this.packagePackageManagerController
  });

  final TextEditingController packageGithubController;
  final TextEditingController packagePackageManagerController;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: packageGithubController,
            prefixIcon: Icon(
              CupertinoIcons.link,
              size: 17,
              color: primaryGrey,
            ),
            title: 'Github Repository',
            hint: 'https://github.com/Wajeeh007/repo',
            includeAsterisk: true,
            validator: (value) => Validators.validateEmptyField(value),
            maxLength: 50,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            prefixIcon: Icon(
              CupertinoIcons.link,
              size: 17,
              color: primaryGrey,
            ),
            includeAsterisk: true,
            maxLength: 50,
            title: 'Package Manager Link',
            controller: packagePackageManagerController,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        )
      ],
    );
  }
}

/// Package likes and version text form fields
class _LikesAndVersionFields extends StatelessWidget {
  const _LikesAndVersionFields({
    required this.packageLikesController,
    required this.packageVersionController
  });

  final TextEditingController packageLikesController;
  final TextEditingController packageVersionController;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomTextFormField(
            hint: 'e.g, 100',
            controller: packageLikesController,
            includeAsterisk: true,
            title: 'Likes',
            validator: (value) => Validators.validateEmptyField(value),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 8,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            hint: 'e.g, 3.4.6',
            includeAsterisk: true,
            controller: packageVersionController,
            title: 'Version',
            validator: (value) => Validators.validateEmptyField(value),
          ),
        )
      ],
    );
  }
}

/// Key Features and Tech Stack Fields
class _KeyFeaturesAndTechStackFields extends StatelessWidget {
  const _KeyFeaturesAndTechStackFields({
    required this.keyFeaturesList,
    required this.techStackList
  });

  final RxList<String> keyFeaturesList;
  final RxList<String> techStackList;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Expanded(
          child: TechStackOrKeyFeaturesField(
            title: 'Key Features',
            list: keyFeaturesList,
            maxChars: 30,
          ),
        ),
        Expanded(
          child: TechStackOrKeyFeaturesField(
            title: 'Tech Stack',
            list: techStackList,
            maxChars: 20,
          ),
        ),
      ],
    );
  }
}

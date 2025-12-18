import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'dart:typed_data';
import '../../helpers/pick_single_image.dart';
import '../../languages/translation_keys.dart' as lang_key;
import '../constants.dart';
import '../images_paths.dart';
import 'custom_cached_network_image.dart';
import 'custom_text_form_field.dart';
import 'heading_in_container_text.dart';
import 'overlay_icon.dart';

class PageBanner extends StatelessWidget {
  const PageBanner({
    super.key,
    required this.mainTitleController,
    required this.subtitleController,
    required this.descriptionController,
    required this.newImage,
    this.imageUrl,
    this.fileInstructions,
    this.includeTopTitle = true,
  });

  final Rx<Uint8List> newImage;
  final String? imageUrl;
  final String? fileInstructions;
  final TextEditingController mainTitleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  final bool includeTopTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 15,
      children: [
        if(includeTopTitle) Align(
          alignment: Alignment.center,
            child: HeadingInContainerText(
              text: 'Page Banner Image/Video',
            )
        ),
        BannerContainer(
          newImage: newImage,
          fileInstructions: fileInstructions,
          imageUrl: imageUrl,
        ),
        SectionContainer(
          children: [
              CustomTextFormField(
                controller: mainTitleController,
                showCounter: true,
                maxLength: 30,
                title: 'Main Title',
                includeAsterisk: true,
              ),
              CustomTextFormField(
                controller: subtitleController,
                title: 'Subtitle',
                includeAsterisk: true,
                maxLength: 30,
                showCounter: true,
              ),
              CustomTextFormField(
                controller: descriptionController,
                title: 'Description',
                includeAsterisk: true,
                maxLength: 50,
                showCounter: true,
              )
            ],
          ),
      ],
    );
  }
}

class BannerContainer extends StatelessWidget {
  const BannerContainer({
    super.key,
    this.fileInstructions,
    required this.newImage,
    this.imageUrl,
  });

  final String? fileInstructions;
  final Rx<Uint8List> newImage;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [14,14],
              strokeWidth: 1.5,
              color: primaryGrey,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 180,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => pickSingleImage(imageToUpload: newImage),
                    child: Obx(() => newImage.value.isNotEmpty && newImage.value != Uint8List(0) ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(newImage.value, fit: BoxFit.fitHeight,),
                        OverlayIcon(iconData: Icons.close, top: 5, right: 5, onPressed: () => newImage.value = Uint8List(0),),
                      ],
                    ) : imageUrl == null ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagesPaths.uploadFile,
                          width: 70,
                          height: 70,
                        ),
                        Text(
                          '${lang_key.uploadFile.tr}...',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: primaryGrey
                          ),
                        )
                      ],
                    ) :
                    CustomNetworkImage(
                      imageUrl: imageUrl!,
                      boxFit: BoxFit.fitHeight,
                    )),
                  )
              ),
            )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            fileInstructions ?? lang_key.fileInstructions.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: primaryGrey
            ),
          ),
        ),
      ],
    );
  }
}
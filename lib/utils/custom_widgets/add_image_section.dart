import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/pick_single_image.dart';
import '../../languages/translation_keys.dart' as lang_key;
import '../constants.dart';
import '../images_paths.dart';
import 'custom_cached_network_image.dart';
import 'heading_in_container_text.dart';
import 'overlay_icon.dart';

/// Add image section
class AddImageSection extends StatelessWidget {
  const AddImageSection({
    super.key,
    required this.newImage,
    this.imageUrl,
    this.fileInstructions,
    this.height,
    this.width,
    this.includeFileInstructions = false
  });

  final Rx<Uint8List> newImage;
  final String? imageUrl;
  final String? fileInstructions;
  final double? height;
  final double? width;
  final bool includeFileInstructions;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        HeadingInContainerText(text: lang_key.image.tr,),
        DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [14,14],
              strokeWidth: 1.5,
              color: primaryGrey,
            ),
            child: SizedBox(
              width: width ?? double.infinity,
              height: height ?? 180,
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
                          width: 50,
                          height: 50,
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
        if(includeFileInstructions) SizedBox(
          width: width ?? double.infinity,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              fileInstructions ?? lang_key.fileInstructions.tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: primaryGrey
              ),
              maxLines: 2,
            ),
          ),
        )
      ],
    );
  }
}
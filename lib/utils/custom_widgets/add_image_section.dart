import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/file_picker_functions.dart';
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
    this.includeFileInstructions = false,
    this.textAlignment = Alignment.center,
    this.includeAsterisk = false,
    this.heading,
    this.boxFit,
    this.headingTextStyle,
    this.fileMaxSize
  });

  final Rx<Uint8List> newImage;
  final String? imageUrl;
  final String? fileInstructions;
  final double? height;
  final double? width;
  final bool includeFileInstructions;
  final Alignment? textAlignment;
  final bool includeAsterisk;
  final String? heading;
  final BoxFit? boxFit;
  final TextStyle? headingTextStyle;

  /// Variable to change the file size as required. The number is in MB
  final int? fileMaxSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Align(
          alignment: textAlignment ?? AlignmentGeometry.centerLeft,
            child: HeadingInContainerText(
              headingTextStyle: headingTextStyle,
              text: heading ?? lang_key.image.tr,
              includeAsterisk: includeAsterisk,
            )
        ),
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
                    onTap: () async {
                      final image = await FilePickerFunctions.pickSingleImage(maxFileSize: fileMaxSize ?? 5);

                      if(image != null) {
                        newImage.value = image.files.first.bytes!;
                      }
                    },
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
                      boxFit: boxFit ?? BoxFit.fitHeight,
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
              fileInstructions ?? 'File Format - .png, .jpg, .jpeg - Max Size - 3MB',
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
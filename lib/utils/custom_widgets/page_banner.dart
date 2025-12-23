import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';
import '../../helpers/pick_single_image.dart';
import '../../languages/translation_keys.dart' as lang_key;
import '../constants.dart';
import '../images_paths.dart';
import 'custom_text_form_field.dart';
import 'heading_in_container_text.dart';
import 'overlay_icon.dart';

class PageBanner extends StatelessWidget {
  const PageBanner({
    super.key,
    required this.mainTitleController,
    required this.subtitleController,
    required this.descriptionController,
    required this.newVideo,
    this.videoController,
    this.fileInstructions,
    this.includeTopTitle = true,
    this.includeCta = false,
    this.ctaTextController,
    this.isVideoControllerInitialized = false,
  }) : assert((includeCta == true && ctaTextController != null) || (includeCta == false && ctaTextController == null));

  final Rx<Uint8List> newVideo;
  final VideoPlayerController? videoController;
  final String? fileInstructions;
  final bool isVideoControllerInitialized;
  final TextEditingController mainTitleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  final TextEditingController? ctaTextController;
  final bool includeTopTitle;
  final bool includeCta;

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
          newVideo: newVideo,
          fileInstructions: fileInstructions,
          videoController: videoController,
          isControllerInitialized: isVideoControllerInitialized,
        ),
        SectionContainer(
          children: [
              CustomTextFormField(
                controller: mainTitleController,
                showCounter: true,
                maxLength: 50,
                title: 'Main Title',
                includeAsterisk: true,
              ),
              CustomTextFormField(
                controller: subtitleController,
                title: 'Subtitle',
                includeAsterisk: true,
                maxLength: 60,
                showCounter: true,
              ),
              CustomTextFormField(
                controller: descriptionController,
                title: 'Description',
                includeAsterisk: true,
                maxLength: 150,
                showCounter: true,
              ),
            if(includeCta) CustomTextFormField(
              title: 'CTA Text',
              includeAsterisk: true,
              controller: ctaTextController,
              maxLines: 1,
              maxLength: 20,
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
    required this.newVideo,
    this.videoController,
    required this.isControllerInitialized
  });

  final String? fileInstructions;
  final Rx<Uint8List> newVideo;
  final VideoPlayerController? videoController;
  final bool isControllerInitialized;

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
              height: 400,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => pickSingleImage(imageToUpload: newVideo),
                    child: Obx(() => newVideo.value.isNotEmpty && newVideo.value != Uint8List(0) ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(newVideo.value, fit: BoxFit.fitHeight,),
                        OverlayIcon(
                          iconData: Icons.close,
                          top: 5,
                          right: 5,
                          onPressed: () => newVideo.value = Uint8List(0),
                        ),
                      ],
                    ) : isControllerInitialized && videoController != null ? videoController!.value.isBuffering ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4.5,
                      ),
                    ) : SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: videoController!.value.size.width,
                          height: videoController!.value.size.height,
                          child: VideoPlayer(videoController!),
                        ),
                      ),
                    ) : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagesPaths.uploadFile, width: 70, height: 70,),
                          Text(
                            lang_key.uploadFile.tr,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primaryGrey
                            ),
                          )
                        ],
                      ),
                    ))
                  ),
              )
            ),
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
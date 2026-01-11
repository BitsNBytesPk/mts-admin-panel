import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/page_banner.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';
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
    required this.formKey,
    required this.bannerOnTap,
    required this.videoLoading,
    required this.isNetworkVideoControllerInitialized,
    required this.isNewVideoControllerInitialized,
    this.closeOnTap,
    this.newVideoController,
    this.networkVideoController,
    this.fileInstructions,
    this.includeTopTitle = true,
    this.includeCta = false,
    this.ctaTextController,
    this.includeButtons = false,
    this.saveOnTap,
  }) : assert((includeCta == true && ctaTextController != null) || (includeCta == false && ctaTextController == null));

  final Rx<Uint8List> newVideo;
  final RxBool videoLoading;
  final CachedVideoPlayerPlus? networkVideoController;
  final VideoPlayerController? newVideoController;
  final String? fileInstructions;
  final RxBool isNetworkVideoControllerInitialized;
  final RxBool isNewVideoControllerInitialized;
  final TextEditingController mainTitleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  final TextEditingController? ctaTextController;
  final GlobalKey<FormState> formKey;
  final bool includeTopTitle;
  final bool includeCta;
  final bool includeButtons;
  final VoidCallback bannerOnTap;
  final VoidCallback? closeOnTap;
  final VoidCallback? saveOnTap;

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
          videoLoading: videoLoading,
          bannerOnTap: bannerOnTap,
          newVideo: newVideo,
          closeOnTap: closeOnTap,
          newVideoController: newVideoController,
          fileInstructions: fileInstructions,
          networkVideoController: networkVideoController,
          isNetworkControllerInitialized: isNetworkVideoControllerInitialized,
          isNewControllerInitialized: isNewVideoControllerInitialized,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: mainTitleController,
                showCounter: true,
                maxLength: mediumTitle,
                title: 'Main Title',
                includeAsterisk: true,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              CustomTextFormField(
                controller: subtitleController,
                title: 'Subtitle',
                includeAsterisk: true,
                maxLength: mediumSubtitle,
                showCounter: true,
                validator: (value) => Validators.validateEmptyField(value),
              ),
              CustomTextFormField(
                controller: descriptionController,
                title: 'Description',
                includeAsterisk: true,
                maxLength: 150,
                showCounter: true,
                validator: (value) => Validators.validateLongDescriptionText(value, minLength: 30),
              ),
              if(includeCta) CustomTextFormField(
                title: 'CTA Text',
                includeAsterisk: true,
                controller: ctaTextController,
                maxLines: 1,
                maxLength: 20,
                showCounter: true,
                // validator: (value) => Validators.validateEmptyField(value),
              ),
            ],
          ),
        ),
        if(includeButtons) Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomMaterialButton(
              width: isSmallScreen(context) ? double.infinity : 150,
                buttonColor: Colors.deepOrangeAccent,
                borderColor: Colors.deepOrangeAccent,
                text: 'Show Preview',
                onPressed: () => Get.toNamed(Routes.bannerPreview, arguments: {
                  'bannerData': PageBannerModel(
                    title: mainTitleController.text,
                    subtitle: subtitleController.text,
                    description: descriptionController.text,
                    ctaText: ctaTextController?.text,
                    newBanner: newVideo.value.isEmpty ? null : newVideo.value,
                    uploadedBanner: newVideo.value.isEmpty ? networkVideoController?.dataSource : null,
                  ).toJson()
                })
            ),
            CustomMaterialButton(
                onPressed: saveOnTap ?? () {},
              text: 'Save',
              width: isSmallScreen(context) ? double.infinity : 150,
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
    this.networkVideoController,
    this.newVideoController,
    required this.isNetworkControllerInitialized,
    required this.isNewControllerInitialized,
    required this.bannerOnTap,
    required this.videoLoading,
    this.closeOnTap,
  });

  final String? fileInstructions;
  final Rx<Uint8List> newVideo;
  final CachedVideoPlayerPlus? networkVideoController;
  final VideoPlayerController? newVideoController;
  final RxBool isNetworkControllerInitialized;
  final RxBool isNewControllerInitialized;
  final VoidCallback bannerOnTap;
  final VoidCallback? closeOnTap;
  final RxBool videoLoading;

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
                  child: Stack(
                    children: [
                      Obx(() => newVideo.value.isNotEmpty && isNewControllerInitialized.value ? Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox.expand(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              clipBehavior: Clip.hardEdge,
                              child: SizedBox(
                                width: newVideoController!.value.size.width,
                                height: newVideoController!.value.size.height,
                                child: VideoPlayer(newVideoController!),
                              ),
                            ),
                          ),
                          OverlayIcon(
                            iconData: Icons.close,
                            top: 5,
                            right: 5,
                            onPressed: closeOnTap ?? () => newVideo.value = Uint8List(0),
                          ),
                        ],
                      ) : isNetworkControllerInitialized.value && networkVideoController != null ? networkVideoController!.controller.value.isBuffering ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4.5,
                        ),
                      ) : SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            width: networkVideoController!.controller.value.size.width,
                            height: networkVideoController!.controller.value.size.height,
                            child: VideoPlayer(networkVideoController!.controller),
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
                      )),
                      Obx(() => videoLoading.value ? Positioned.fill(
                        child: ColoredBox(
                          color: Colors.black12,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4.5,
                              color: primaryWhite,
                            ),
                          ),
                        ),
                      ) : SizedBox()),
                      Obx(() => videoLoading.isFalse && newVideo.value.isEmpty ? Positioned.fill(
                          child: InkWell(
                            overlayColor: WidgetStatePropertyAll(Colors.transparent),
                            onTap: bannerOnTap
                          )
                      ) : SizedBox())
                    ],
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_cached_network_image.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/project_stats_heading_and_value_text.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../../../models/innovation_data.dart';
import 'innovation_project_preview_viewmodel.dart';

class InnovationProjectPreviewView extends StatelessWidget {
  InnovationProjectPreviewView({super.key});

  final InnovationProjectPreviewViewModel _viewModel = Get.put(InnovationProjectPreviewViewModel());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryWhite,
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Obx(() => SizedBox(
                  width: isSmallScreen(context) ? MediaQuery.sizeOf(context).width * 0.9 : MediaQuery.sizeOf(context).width * 0.8,
                    height: 400,
                    child: Stack(
                      children: [
                        if(_viewModel.project.value.image != null && (_viewModel.project.value.newImage == null || _viewModel.project.value.newImage!.isEmpty)) CustomNetworkImage(
                            imageUrl: "${Urls.baseURL}${_viewModel.project.value.image}",
                            width: double.infinity,
                            height: double.infinity,
                            boxFit: BoxFit.cover,
                        ),
                        if(_viewModel.project.value.newImage != null && _viewModel.project.value.newImage!.isNotEmpty) Image.memory(
                          _viewModel.project.value.newImage!,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    primaryDarkBlue.withValues(alpha: 0.2),
                                    primaryDarkBlue.withValues(alpha: 0.6),
                                  ]
                                )
                              ),
                            )
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
                            child: Column(
                              spacing: 15,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _viewModel.project.value.category?.toUpperCase() ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: pageBannerSubtitleTextColor
                                  ),
                                ),
                                Text(
                                  _viewModel.project.value.title ?? '',
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 35,
                                    color: primaryWhite
                                  )
                                ),
                                Text(
                                  _viewModel.project.value.description ?? '',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: primaryWhite.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w300
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    children: List.generate(_viewModel.project.value.metrics?.length ?? 0, (index) {
                                      return StatsHeadingAndValue(
                                          label: _viewModel.project.value.metrics?[index].label ?? '',
                                          value: _viewModel.project.value.metrics?[index].value ?? ''
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                )),
                SizedBox(height: 60,),
                SizedBox(
                  width: isSmallScreen(context) ? MediaQuery.sizeOf(context).width * 0.88 : MediaQuery.sizeOf(context).width * 0.77,
                  child: !isSmallScreen(context) ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 25,
                    children: [
                      Expanded(
                        child: Obx(() => _ApplicationOrTechnologyListing(
                              heading: 'Technology',
                              subtitle: _viewModel.project.value.technology?.heading ?? '',
                            child: Column(
                                spacing: 20,
                                children: List.generate(_viewModel.project.value.technology?.items?.length ?? 0, (index) {
                                  return Row(
                                    spacing: 15,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: pageBannerSubtitleTextColor,
                                        ),
                                        child: Text(
                                          "0${(index + 1).toString()}",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: primaryWhite,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              _viewModel.project.value.technology?.items?[index].title ?? '',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              _viewModel.project.value.technology?.items?[index].description ?? '',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Obx(() => _ApplicationOrTechnologyListing(
                            heading: 'Application',
                            subtitle: _viewModel.project.value.applications?.heading ?? '',
                            child: Column(
                                spacing: 15,
                                children: List.generate(
                                    _viewModel.project.value.applications?.items?.length ?? 0, (index) {

                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          border: Border.all(
                                            color: primaryGrey.withValues(alpha: 0.4),
                                            width: 0.3
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 15,
                                          children: [
                                            Text(
                                              _viewModel.project.value.applications?.items?[index].title ?? '',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              _viewModel.project.value.applications?.items?[index].description ?? '',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      );
                                }),
                              ),
                            )),
                      ),
                    ],
                  ) : Column(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _ApplicationOrTechnologyListing extends StatelessWidget {
  const _ApplicationOrTechnologyListing({
    required this.heading,
    required this.subtitle,
    required this.child
  });

  final String heading;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 18.5,
            color: pageBannerSubtitleTextColor
          ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 33,
            fontWeight: FontWeight.w400
          ),
        ),
        child
      ],
    );
  }
}

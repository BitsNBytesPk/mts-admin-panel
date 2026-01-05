import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_cached_network_image.dart';

import 'responsibility_project_preview_viewmodel.dart';

class ResponsibilityProjectPreviewView extends StatelessWidget {
  ResponsibilityProjectPreviewView({super.key});

  final ResponsibilityProjectPreviewViewModel _viewModel = Get.put(ResponsibilityProjectPreviewViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width <= 1000 && MediaQuery.sizeOf(context).width >= 750 ? MediaQuery.sizeOf(context).width * 0.75 : isSmallScreen(context) ? MediaQuery.sizeOf(context).width * 0.85 : MediaQuery.sizeOf(context).width * 0.5,
          height: 500,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                alignment: AlignmentGeometry.topCenter,
                scale: 1.2,
                child: CustomNetworkImage(
                  radius: 0,
                    imageUrl: _viewModel.responsibilityProjectCard.value.image ?? '',
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        primaryDarkBlue.withValues(alpha: 0.8),
                      ],
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _viewModel.responsibilityProjectCard.value.tag ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: pageBannerSubtitleTextColor
                      )
                    ),
                    Text(
                      _viewModel.responsibilityProjectCard.value.title ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 40,
                        color: primaryWhite
                      ),
                    ),
                    Text(
                      _viewModel.responsibilityProjectCard.value.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: primaryWhite.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        _StatsHeadingAndValue(label: _viewModel.responsibilityProjectCard.value.metrics?[0].label ?? '', value: _viewModel.responsibilityProjectCard.value.metrics?[0].value ?? ''),
                        _StatsHeadingAndValue(label: _viewModel.responsibilityProjectCard.value.metrics?[1].label ?? '', value: _viewModel.responsibilityProjectCard.value.metrics?[1].value ?? ''),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsHeadingAndValue extends StatelessWidget {
  const _StatsHeadingAndValue({
    required this.label,
    required this.value
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.amber
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w200,
              color: primaryWhite.withValues(alpha: 0.7),
              // fontSize: 16
            )
          )
        ],
      ),
    );
  }
}
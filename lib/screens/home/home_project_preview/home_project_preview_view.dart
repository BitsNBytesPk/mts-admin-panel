import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

import 'home_project_preview_viewmodel.dart';

class HomeProjectPreviewView extends StatelessWidget {
  HomeProjectPreviewView({super.key});

  final HomeProjectPreviewViewModel _viewModel = Get.put(HomeProjectPreviewViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          width: MediaQuery.sizeOf(context).width <= 1000 && MediaQuery.sizeOf(context).width >= 750 ? MediaQuery.sizeOf(context).width * 0.75 : isSmallScreen(context) ? MediaQuery.sizeOf(context).width * 0.85 : MediaQuery.sizeOf(context).width * 0.5,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(int.parse(_viewModel.homeProjectCard.value.style?.gradientFrom?.substring(1, 7) ?? "#00345C".substring(1,7), radix: 16) + 0xFF000000),
                  Color(int.parse(_viewModel.homeProjectCard.value.style?.gradientTo?.substring(1, 7) ?? "#05DDFB".substring(1,7), radix: 16) + 0xFF000000),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
            )
          ),
          child: Obx(() => Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _viewModel.homeProjectCard.value.title ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 40,
                    color: primaryWhite
                  ),
                ),
                Text(
                  _viewModel.homeProjectCard.value.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primaryWhite.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: List.generate(_viewModel.homeProjectCard.value.metrics?.length ?? 0, (index) {
                    return _StatsHeadingAndValue(label: _viewModel.homeProjectCard.value.metrics?[index].label ?? '', value: _viewModel.homeProjectCard.value.metrics?[index].value ?? '');
                  }),
                )
              ],
            ),
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

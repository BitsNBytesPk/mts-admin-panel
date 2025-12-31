import 'package:flutter/material.dart';

import '../constants.dart';
import '../validators.dart';
import 'custom_text_form_field.dart';

class InformaticsOrStatsTextFormFields extends StatelessWidget {
  const InformaticsOrStatsTextFormFields({
    super.key,
    required this.headingController,
    required this.subtitleController,
    this.includeTitle = false,
    this.onTap,
    this.includeButton = false,
    this.headingText,
    this.subtitleText,
    this.headingMaxLength,
    this.subtitleMaxLength,
    this.showHeadingCounter = false,
    this.showSubtitleCounter = false,
  });

  final bool includeButton;
  final VoidCallback? onTap;
  final bool includeTitle;
  final TextEditingController headingController;
  final TextEditingController subtitleController;
  final String? headingText;
  final String? subtitleText;
  final int? headingMaxLength;
  final int? subtitleMaxLength;
  final bool showHeadingCounter;
  final bool showSubtitleCounter;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 15,
      children: [
        Expanded(
          child: CustomTextFormField(
            title: includeTitle ? headingText ?? 'Heading' : null,
            controller: headingController,
            includeAsterisk: true,
            showCounter: showHeadingCounter,
            maxLength: headingMaxLength,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            title: includeTitle ? subtitleText ?? 'Subtitle' : null,
            controller: subtitleController,
            showCounter: showSubtitleCounter,
            maxLength: subtitleMaxLength,
            includeAsterisk: true,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        ),
        if(includeButton) InkWell(
          onTap: onTap,
          child: Icon(
            Icons.remove_circle_outline_rounded,
            color: errorRed,
            size: 20,
          ),
        )
      ],
    );
  }
}
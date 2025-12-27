import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

class PageHeadingText extends StatelessWidget {
  const PageHeadingText({
    super.key,
    required this.headingText
  });

  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold
      ),
    );
  }
}

class SectionHeadingText extends StatelessWidget {
  const SectionHeadingText({
    super.key,
    required this.headingText
  });

  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        fontSize: isSmallScreen(context) ? 20 : 25,
      ),
    );
  }
}

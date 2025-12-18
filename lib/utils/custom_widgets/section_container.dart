import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.children,
    this.spacing = 10
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: kContainerBoxDecoration,
      child: Column(
        spacing: spacing,
        children: children,
      )
    );
  }
}

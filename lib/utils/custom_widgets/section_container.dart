import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.children,
    this.spacing = 10,
    this.formKey
  });

  final List<Widget> children;
  final double spacing;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: kContainerBoxDecoration,
      child: Form(
        key: formKey,
        child: Column(
          spacing: spacing,
          children: children,
        ),
      )
    );
  }
}

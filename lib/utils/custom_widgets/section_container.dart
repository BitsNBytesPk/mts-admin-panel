import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/heading_texts.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.children,
    required this.height,
    this.spacing = 10,
    this.formKey,
    this.headingText,
    this.includeArrow = true,
    this.onTap
  });

  final List<Widget> children;
  final double spacing;
  final GlobalKey<FormState>? formKey;
  final RxnDouble height;
  final String? headingText;
  final VoidCallback? onTap;
  final bool includeArrow;

  @override
  Widget build(BuildContext context) {

    return Obx(() => AnimatedContainer(
      alignment: AlignmentGeometry.center,
        duration: Duration(milliseconds: 750),
        height: height.value,
        padding: EdgeInsets.all(15),
        decoration: kContainerBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spacing,
          children: [
            if(headingText != null && headingText != '') Row(
              children: [
                Expanded(child: SectionHeadingText(headingText: headingText!)),
                if(includeArrow) InkWell(
                  onTap: () {
                    if(height.value == kSectionHeightValue) {
                      height.value = null;
                    } else {
                      height.value = kSectionHeightValue;
                    }
                  },
                  child: Icon(
                    height.value == kSectionHeightValue ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: primaryGrey,
                    size: isSmallScreen(context) ? 23 : 30,
                  )),
              ],
            ),
            Visibility(
              visible: height.value != kSectionHeightValue,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spacing,
                  children: children,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
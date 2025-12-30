import 'package:flutter/material.dart';

import '../constants.dart';

class HeadingInContainerText extends StatelessWidget {
  const HeadingInContainerText({super.key, required this.text, this.includeAsterisk = false});

  final String text;
  final bool includeAsterisk;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold
          ),
          children: includeAsterisk ? [
            TextSpan(
              text: ' *',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: errorRed,
              ),
            ),
          ] : []
      ),
    );
  }
}

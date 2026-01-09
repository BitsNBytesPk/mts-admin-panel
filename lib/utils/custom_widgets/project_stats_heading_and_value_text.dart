import 'package:flutter/material.dart';

import '../constants.dart';

class StatsHeadingAndValue extends StatelessWidget {
  const StatsHeadingAndValue({
    super.key,
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
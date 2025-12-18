import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/stop_loader_and_show_snackbar.dart';
import '../constants.dart';
import '../validators.dart';
import 'custom_text_form_field.dart';

class TechStackOrKeyFeaturesField extends StatelessWidget {
  TechStackOrKeyFeaturesField({super.key,
    required this.title,
    required this.list,
    required this.maxChars
  });

  final String title;
  final RxList<String> list;
  final int maxChars;

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomTextFormField(
          title: title,
          maxLength: maxChars,
          includeAsterisk: true,
          validator: (value) => Validators.validateTechStackOrKeyFeatures(list),
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: (value) {
            if(value.isNotEmpty && value != '' && list.length < 8){
              list.add(value);
              list.refresh();
              controller.clear();
              focusNode.requestFocus();
            } else if(list.length == 7) {
              showSnackBar(message: 'Only 7 entries are allowed', success: false);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '(Press enter to add new entry)',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Obx(() => Padding(
          padding: EdgeInsets.only(top: 8, left: 5),
          child: Wrap(
            spacing: 5,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            runSpacing: 5,
            children: List.generate(list.length, (index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: primaryGrey.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: [
                    Text(
                      list[index],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        list.removeAt(index);
                        list.refresh();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: errorRed,
                        size: 15,
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
        )
      ],
    );
  }
}
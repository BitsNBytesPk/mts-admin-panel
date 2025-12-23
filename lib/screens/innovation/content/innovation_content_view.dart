import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/list_base_container.dart';
import '../../../helpers/pick_single_image.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../utils/custom_widgets/heading_texts.dart';
import '../../../utils/custom_widgets/overlay_icon.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/custom_widgets/section_container.dart';
import '../../../utils/constants.dart'; // for colors like errorRed
import '../../../utils/images_paths.dart';
import 'innovation_content_viewmodel.dart';

class InnovationContentView extends StatelessWidget {
  InnovationContentView({super.key});

  final InnovationContentViewModel _viewModel = Get.put(InnovationContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
      selectedSidePanelItem: 6,
      children: [
        PageHeadingText(headingText: 'Add Project'),
        SectionContainer(
          children: [
            SectionHeadingText(headingText: 'Banner Details'),
            DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [14,14],
                  strokeWidth: 1.5,
                  color: primaryGrey,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => pickSingleImage(imageToUpload: Uint8List(0).obs),
                        child: Obx(() => Uint8List(0).obs.value.isNotEmpty && Uint8List(0).obs.value != Uint8List(0) ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.memory(Uint8List(0).obs.value, fit: BoxFit.fitHeight,),
                            OverlayIcon(iconData: Icons.close, top: 5, right: 5, onPressed: () => Uint8List(0).obs.value = Uint8List(0),),
                          ],
                        ) : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImagesPaths.uploadFile,
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              'Upload Image',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: primaryGrey
                              ),
                            )
                          ],
                        )),
                      )
                  ),
                )
            ),
            CustomTextFormField(
              title: 'Label',
              includeAsterisk: true,
              controller: _viewModel.overviewLabelController,
            ),
            CustomTextFormField(
              title: 'Heading',
              includeAsterisk: true,
              controller: _viewModel.overviewHeadingController,
            ),
            CustomTextFormField(
              title: 'Description',
              includeAsterisk: true,
              controller: _viewModel.overviewDescController,
              maxLines: 3,
              maxLength: 200,
            ),
            SectionHeadingText(headingText: 'Stats'),
            Obx(() => Column(
              children: [
                for (var item in _viewModel.informaticsList)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: 'Label',
                            controller: item.labelController,
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            includeAsterisk: true,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomTextFormField(
                            title: 'Value',
                            controller: item.valueController,
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                            includeAsterisk: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline_outlined, color: Colors.red, size: 18,),
                          onPressed: () => _viewModel.removeInformatics(item),
                          tooltip: 'Remove Row',
                        ),
                      ],
                    ),
                  ),
                   if(_viewModel.informaticsList.length < 3)
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: _viewModel.addInformatics,
                         icon: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryBlue
                            ),
                            child: Icon(Icons.add, color: Colors.white,)
                        ),
                        tooltip: "Add Informatics Row",
                      ),
                    )
              ],
            )),
            Row(
              children: [
                Text(
                  'Add '
                )
              ],
            )
          ],
        ),
        SectionHeadingText(headingText: 'Projects'),
        ListBaseContainer(
            listData: RxList(),
            columnsNames: [],
            onRefresh: () {}
        )
      ],
    );
  }
}

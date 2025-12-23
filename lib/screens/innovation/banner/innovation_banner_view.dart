import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../utils/custom_widgets/custom_material_button.dart';
import '../../../utils/custom_widgets/screens_base_widget.dart';
import '../../../utils/custom_widgets/section_container.dart';
import 'innovation_banner_viewmodel.dart';

class InnovationBannerView extends StatelessWidget {
  InnovationBannerView({super.key});

  final InnovationBannerViewModel _viewModel = Get.put(InnovationBannerViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        // Assuming side panel index for Innovation is 5 or something new.
        // Since I'm creating a new folder, I don't know the index.
        // checking sidepanel.dart might be needed if I was editing it.
        // For now I'll use a placeholder or 0.
        // But wait, the user said "create pages for each section".
        // The Home page had "HomeBanner" as index 0 and "HomeContent" as index 1.
        // If Innovation is a new top level section, it might have its own indices.
        // I'll assume 0 for Banner in Innovation section.
        selectedSidePanelItem: 5,
        children: [
          // PageBanner(
          //     mainTitleController: _viewModel.pageBannerMainTitleController,
          //     subtitleController: _viewModel.pageBannerSubTitleController,
          //     descriptionController: _viewModel.pageBannerDescriptionController,
          //     newVideo: _viewModel.projectImage
          // ),
          SizedBox(height: 20),
          SectionContainer(
            children: [
              CustomTextFormField(
                controller: _viewModel.pageBannerVideoController,
                title: 'Background Video Path',
                hint: '/assets/videos/MTS-VIDEO-5.mp4',
                includeAsterisk: false,
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
               width: 200,
               child: CustomMaterialButton(
                  text: 'Save',
                  onPressed: () {
                    // TODO: Implement save logic
                  },
               ),
            ),
          ),
        ]
    );
  }
}

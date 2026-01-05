import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/contact/messages/messages_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';

class MessagesView extends StatelessWidget {
  MessagesView({super.key});

  final MessagesViewModel _viewModel = Get.put(MessagesViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      selectedSidePanelItem: 13,
      scrollController: _viewModel.scrollController,
      children: [],
    );
  }
}

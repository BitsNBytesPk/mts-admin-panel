import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class AboutContentViewModel extends GetxController {

  /// Controller(s) & Global Key
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController pageBannerDescriptionController = TextEditingController();

  TextEditingController milestoneDescController = TextEditingController();
  TextEditingController milestoneTitleController = TextEditingController();
  TextEditingController milestoneYearTextController = TextEditingController();

  ScrollController scrollController = ScrollController();

  GlobalKey<FormState> personalDetailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> milestoneDetailsFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }
}
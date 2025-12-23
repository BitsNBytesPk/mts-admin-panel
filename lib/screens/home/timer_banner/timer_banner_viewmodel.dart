import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helpers/scroll_controller_funcs.dart';

class HomeTimerBannerViewModel extends GetxController {

  /// Controller(s) & Global Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController firstInformaticsHeadingController = TextEditingController();
  TextEditingController firstInformaticsValueController = TextEditingController();
  TextEditingController secondInformaticsHeadingController = TextEditingController();
  TextEditingController secondInformaticsValueController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Banner Start and End Times variables
  DateTime? startDate;
  DateTime? endDate;

  /// Flag to enable value textformfield of first informatics
  RxBool enableFirstInformaticsValueField = false.obs;
  RxBool enableSecondInformaticsValueField = false.obs;
  RxBool secondInformaticsAdded = false.obs;

  @override
  void onReady() {
    // GlobalVariables.selectedSidePanelItemIndex =
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }
}
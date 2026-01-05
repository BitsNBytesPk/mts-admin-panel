
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import '../utils/constants.dart';

void animateSidePanelScrollController(ScrollController scrollController, {String? routeName}) {

  final sidePanelItem = routeName == null || routeName == '' ? sidePanelItemsData.firstWhere((element) => element.routeName == Get.currentRoute) : sidePanelItemsData.firstWhere((element) => element.routeName == routeName);
  GlobalVariables.selectedSidePanelItemIndex.value = sidePanelItem.sidePanelItemIndex;
  if(!isSmallScreen(Get.context!)) {
    Future.delayed(Duration(seconds: 1), () => scrollController.animateTo(
        sidePanelItem.scrollPosition,
        duration: sidePanelAnimationDuration,
        curve: sidePanelAnimationCurve
    ));
  }
}

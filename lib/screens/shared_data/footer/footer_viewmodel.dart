import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/models/shared_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

class FooterViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();
  TextEditingController brandStatementController = TextEditingController();
  TextEditingController copyRightsController = TextEditingController();
  RxMap<TextEditingController, TextEditingController> socialLinks = <TextEditingController, TextEditingController>{}.obs;

  GlobalKey<FormState> footerBasicDataFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> socialLinksFormKey = GlobalKey<FormState>();

  /// Forms Height Variables
  RxnDouble basicDataFormHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble socialLinksFormHeight = RxnDouble(kSectionContainerHeightValue);

  /// Shared Data
  Rx<SharedData> sharedAppData = SharedData().obs;

  @override
  void onReady() {
    _fetchSharedData();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void _fetchSharedData() {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.sharedData).then((value) {
      GlobalVariables.showLoader.value = false;

      if(value.success!) {
        sharedAppData.value = SharedData.fromJson(value.data);
        _fillFooterBasicTextControllers();
        _fillSocialLinksControllers();
      }
    });
  }

  void _fillFooterBasicTextControllers() {
    brandStatementController.text = sharedAppData.value.content?.footer?.tagline ?? '';
    copyRightsController.text = sharedAppData.value.content?.footer?.copyright ?? '';

  }

  void _fillSocialLinksControllers() {
    sharedAppData.value.content?.socialLinks?.forEach((element) {
      socialLinks.addAll({TextEditingController(text: element.label): TextEditingController(text: element.uri)});

    });
  }
}
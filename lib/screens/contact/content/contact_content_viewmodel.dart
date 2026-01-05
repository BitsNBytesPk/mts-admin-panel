import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/scroll_controller_funcs.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';

import '../../../models/contact_data.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class ContactContentViewModel extends GetxController {

  /// Controller(s) & Form Key(s)
  ScrollController scrollController = ScrollController();

  RxList<TextEditingController> emails = <TextEditingController>[].obs;
  RxMap<TextEditingController, TextEditingController> phoneNos = <TextEditingController, TextEditingController>{}.obs;
  RxMap<TextEditingController, List<TextEditingController>> offices = <TextEditingController, List<TextEditingController>>{}.obs;
  RxList<TextEditingController> whatsapp = <TextEditingController>[].obs;

  GlobalKey<FormState> emailsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> locationsFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> whatsappFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  /// SectionContainer(s) height variables
  RxnDouble locationFormHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble emailsFormHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble whatsappFormHeight = RxnDouble(kSectionContainerHeightValue);
  RxnDouble phoneFormHeight = RxnDouble(kSectionContainerHeightValue);

  Rx<ContactData> contactData = ContactData().obs;

  @override
  void onReady() {
    _fetchInitialDataForContactBanner();
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void _fetchInitialDataForContactBanner() {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.contactData).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        contactData.value = ContactData.fromJson(value.data);
        _fillOfficeLocationControllers();
        _fillEmailsControllers();
        _fillPhoneControllers();
        _fillWhatsappControllers();
      }
    });
  }

  void _fillOfficeLocationControllers() {

    contactData.value.content?.sidebar?.cards?.office?.forEach((element) {

      List<TextEditingController> addressLines = [];
        element.lines?.forEach((v) {

            addressLines.add(TextEditingController(text: v));

            if(v == element.lines?.last) {
              offices.addAll({
                TextEditingController(text: element.title): addressLines
              });
            }
          });

      if(element == contactData.value.content?.sidebar?.cards?.office?.last) {
        offices.refresh();
      }
    });

  }

  void _fillEmailsControllers() {

    contactData.value.content?.sidebar?.cards?.mail?.forEach((element) {
      emails.add(TextEditingController(text: element.primary));
    });
  }

  void _fillPhoneControllers() {
    contactData.value.content?.sidebar?.cards?.phone?.forEach((element) {
      phoneNos.addAll({
        TextEditingController(text: element.label): TextEditingController(text: element.number)
      });
      phoneNos.refresh();
    });
  }

  void _fillWhatsappControllers() {
    contactData.value.content?.sidebar?.cards?.whatsapp?.forEach((element) {
      whatsapp.addAll({
        TextEditingController(text: element.primary)
      });
      whatsapp.refresh();
    });
  }
}
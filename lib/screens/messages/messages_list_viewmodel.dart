import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;
import '../../helpers/populate_lists.dart';
import '../../helpers/scroll_controller_funcs.dart';
import '../../helpers/stop_loader_and_show_snackbar.dart';
import '../../models/message.dart';
import '../../utils/api_base_helper.dart';
import '../../utils/constants.dart';
import '../../utils/custom_widgets/custom_material_button.dart';
import '../../utils/global_variables.dart';
import '../../utils/url_paths.dart';
import 'message_analytics_model.dart';

class MessagesListViewModel extends GetxController with GetSingleTickerProviderStateMixin {

  /// Controller(s) and Form Keys
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  
    /// All messages list search controller
    TextEditingController allMessagesSearchController = TextEditingController();
    
    /// Unread Messages List Search controller
    TextEditingController unreadMessagesSearchController = TextEditingController();
    
  /// All Messages data list
  List<Message> allMessagesList = <Message>[];
  RxList<Message> visibleAllMessagesList = <Message>[].obs;

  /// Unread messages data list
  List<Message> allUnreadMessagesList = <Message>[];
  RxList<Message> visibleUnreadMessagesList = <Message>[].obs;

  /// 'All' Tab pagination variables
  int allTabLimit = 10;
  RxInt allTabPage = 0.obs;
  
  /// 'Unread' Tab pagination variables
  int unreadTabLimit = 10;
  RxInt unreadTabPage = 0.obs;

  /// Messages Analytical data variable
  Rx<MessageAnalyticsModel> messagesAnalyticalData = MessageAnalyticsModel().obs;
  
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    GlobalVariables.showLoader.value = true;
    animateSidePanelScrollController(scrollController);
    fetchMessagesLists();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    allMessagesSearchController.dispose();
    unreadMessagesSearchController.dispose();
    super.onClose();
  }
  
  /// Fetch messages list for each tab
  void fetchMessagesLists() async {

    if(GlobalVariables.showLoader.isFalse) GlobalVariables.showLoader.value = true;

    final fetchAllMessages = ApiBaseHelper.getMethod(url: "${Urls.getMessages}?limit=$allTabLimit&page=${allTabPage.value}");
    final fetchUnreadMessages = ApiBaseHelper.getMethod(url: "${Urls.getMessages}?limit=$unreadTabLimit&page=${unreadTabPage.value}&is_read=false");
    final fetchMessagesAnalyticalData = ApiBaseHelper.getMethod(url: Urls.getMessagesStats);
    
    final responses = await Future.wait([
      fetchAllMessages,
      fetchUnreadMessages,
      fetchMessagesAnalyticalData
    ]);
    
    if(responses[0].success!) populateLists<Message, dynamic>(allMessagesList, responses[0].data as List, visibleAllMessagesList, (dynamic json) => Message.fromJson(json));
    if(responses[1].success!) populateLists<Message, dynamic>(allUnreadMessagesList, responses[1].data as List, visibleUnreadMessagesList, (dynamic json) => Message.fromJson(json));
    if(responses[2].success!) _populateAnalyticalData(responses[2].data);

    if(responses.isEmpty || responses.every((element) => !element.success!)) {
      showSnackBar(message: "${lang_key.generalApiError.tr}. ${lang_key.retry.tr}", success: false);
    }

    GlobalVariables.showLoader.value = false;
  }

  void fetchUnreadMessages() {
    ApiBaseHelper.getMethod(
        url: "${Urls.getMessages}?limit=$unreadTabLimit&page=${unreadTabPage.value}&is_read=false"
    ).then((value) {
      if(value.success!) populateLists<Message, dynamic>(allUnreadMessagesList, value.data as List, visibleUnreadMessagesList, (dynamic json) => Message.fromJson(json));
    });
  }

  /// Add data to the analytical data map variable.
  void _populateAnalyticalData(Map<String, dynamic> data) {
    messagesAnalyticalData.value = MessageAnalyticsModel.fromJson(data);
  }

  /// Search Message by sender's name or email.
  void searchList(String? value, List<Message> list, RxList<Message> visibleList) {
    if(value == null || value.isEmpty || value == '') {
      addDataToVisibleList(list, visibleList);
    } else {
      addDataToVisibleList(
          list.where((element) => element.name!.toLowerCase().contains(value.toLowerCase()) || element.email!.toLowerCase().contains(value.toLowerCase())).toList(),
          visibleList
      );
    }
  }

  void _markMessageAsRead(Message message) {
    ApiBaseHelper.patchMethod(
        url: Urls.changeMessageStatus(message.id!),
    ).then((value) {
      if(value.success!) {

        int unreadMessagesIndex = allUnreadMessagesList.indexWhere((element) => element.id == message.id);

        int allMessagesIndex = allMessagesList.indexWhere((element) => element.id == message.id);

        if(allMessagesIndex != -1) {
          allMessagesList[allMessagesIndex].isRead = true;
        } else {
          allMessagesList.add(allUnreadMessagesList[unreadMessagesIndex]);
        }

        addDataToVisibleList(allMessagesList, visibleAllMessagesList);

        if(unreadMessagesIndex != -1) {
          allUnreadMessagesList.removeAt(unreadMessagesIndex);
          addDataToVisibleList(allUnreadMessagesList, visibleUnreadMessagesList);
        }

      }
    });
  }
  
  /// Message details dialog. Shows the complete details of the message.
  Future<void> showMessageDetailsDialog(Message message) {
    if(!message.isRead!) _markMessageAsRead(message);
    return showDialog(
        context: Get.context!,
        barrierColor: Colors.black38,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: primaryWhite,
            title: Text('Message Details', textAlign: TextAlign.center,),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText.rich(
                  TextSpan(
                    text: "${lang_key.name.tr}: ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                    children: [
                      TextSpan(
                        text: message.name,
                        style: Theme.of(context).textTheme.bodyMedium
                      )
                    ]
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                      text: "${lang_key.email.tr}: ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                            text: message.email,
                            style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                  ),
                ),
                SelectableText.rich(
                  TextSpan(
                      text: "Message: ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                            text: message.message,
                            style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                  ),
                )
              ],
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CustomMaterialButton(
                width: 200,
                onPressed: () {
                  int unreadMessagesIndex = allUnreadMessagesList.indexWhere((element) => element.id == message.id);
                  int allMessagesIndex = allMessagesList.indexWhere((element) => element.id == message.id);

                  if(unreadMessagesIndex != -1) {
                    _markMessageAsRead(message);
                  }

                  if(allMessagesIndex != -1 && allMessagesList[allMessagesIndex].isRead == false) {
                    _markMessageAsRead(allMessagesList[allMessagesIndex]);
                  }

                  Get.back();
                },
                text: lang_key.cont.tr,
                textColor: primaryBlue,
                buttonColor: primaryWhite,
              ),
            ],
          );
        });
  }
  
}
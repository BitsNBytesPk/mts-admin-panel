import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mts_website_admin_panel/languages/translation_keys.dart' as lang_key;

import '../../utils/constants.dart';
import '../../utils/custom_widgets/custom_tab_bar.dart';
import '../../utils/custom_widgets/list_actions_buttons.dart';
import '../../utils/custom_widgets/list_base_container.dart';
import '../../utils/custom_widgets/list_entry_item.dart';
import '../../utils/custom_widgets/list_serial_no_text.dart';
import '../../utils/custom_widgets/screens_base_widget.dart';
import '../../utils/custom_widgets/heading_texts.dart';
import '../../utils/custom_widgets/stats_container.dart';
import 'messages_list_viewmodel.dart';

class MessagesListView extends StatelessWidget {
  MessagesListView({super.key});

  final MessagesListViewModel _viewModel = Get.put(MessagesListViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
      scrollController: _viewModel.scrollController,
        selectedSidePanelItem: 6,
        children: [
          _MessagesAnalyticsData(),
          PageHeadingText(headingText: lang_key.messagesList.tr),
          CustomTabBar(
              controller: _viewModel.tabController,
              tabsNames: [
                lang_key.all.tr,
                'Unread',
              ]
          ),
          SizedBox(
            height: 800,
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _viewModel.tabController,
                children: [

                  _AllMessagesListTabView(),
                  _UnreadMessagesListTabView(),
                ]
            ),
          )
        ],
    );
  }
}

/// Messages Analytics data
class _MessagesAnalyticsData extends StatelessWidget {
  _MessagesAnalyticsData();

  final MessagesListViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeadingText(headingText: lang_key.messagesAnalyticalData.tr),
        Obx(() => Row(
            spacing: 15,
            children: [
              StatsContainer(
                height: 200,
                statValue: _viewModel.messagesAnalyticalData.value.total ?? 0,
                statName: lang_key.totalMessages.tr,
                iconContainerColor: Colors.purpleAccent,
                iconData: CupertinoIcons.list_dash,
              ),
              StatsContainer(
                height: 200,
                statValue: _viewModel.messagesAnalyticalData.value.unread ?? 0,
                statName: 'Unread Messages',
                iconData: Icons.mark_chat_unread,
                iconContainerColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// All Messages list tab view
class _AllMessagesListTabView extends StatelessWidget {
  _AllMessagesListTabView();

  final MessagesListViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => ListBaseContainer(
            onSearch: (value) => _viewModel.searchList(value, _viewModel.allMessagesList, _viewModel.visibleAllMessagesList),
            onRefresh: () => _viewModel.fetchMessagesLists(),
              controller: _viewModel.allMessagesSearchController,
              listData: _viewModel.visibleAllMessagesList,
              expandFirstColumn: false,
              hintText: lang_key.searchMessage.tr,
              columnsNames: [
                lang_key.sl.tr,
                lang_key.name.tr,
                lang_key.email.tr,
                'Read',
                lang_key.date.tr,
                lang_key.actions.tr
              ],
          entryChildren: List.generate(_viewModel.visibleAllMessagesList.length, (index) {

            return Padding(
                padding: listEntryPadding.copyWith(bottom: 5),
              child: Row(
                children: [
                  ListSerialNoText(index: index),
                  ListEntryItem(text: _viewModel.visibleAllMessagesList[index].name ?? '', maxLines: 1,),
                  ListEntryItem(text: _viewModel.visibleAllMessagesList[index].email ?? '', maxLines: 1,),
                  ListEntryItem(text: _viewModel.visibleAllMessagesList[index].isRead! ? lang_key.yes.tr : lang_key.no.tr,),
                  ListEntryItem(text: _viewModel.visibleAllMessagesList[index].createdAt != null ? DateFormat('dd/MM/yyyy').format(_viewModel.visibleAllMessagesList[index].createdAt!) : ''),
                  ListActionsButtons(
                      includeDelete: false,
                      includeEdit: false,
                      includeView: true,
                    onViewPressed: () => _viewModel.showMessageDetailsDialog(_viewModel.visibleAllMessagesList[index]),
                  )
                ],
              ),
            );
          }),
          ),
        ),
      ],
    );
  }
}

/// Unread Messages Tab View
class _UnreadMessagesListTabView extends StatelessWidget {
  _UnreadMessagesListTabView();

  final MessagesListViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => ListBaseContainer(
            onSearch: (value) => _viewModel.searchList(value, _viewModel.allMessagesList, _viewModel.visibleAllMessagesList),
            onRefresh: () => _viewModel.fetchUnreadMessages(),
          controller: _viewModel.unreadMessagesSearchController,
          listData: _viewModel.visibleUnreadMessagesList,
          expandFirstColumn: false,
          hintText: lang_key.searchMessage.tr,
          columnsNames: [
            lang_key.sl.tr,
            lang_key.name.tr,
            lang_key.email.tr,
            lang_key.date.tr,
            lang_key.actions.tr
          ],
          entryChildren: List.generate(_viewModel.visibleUnreadMessagesList.length, (index) {

            return Padding(
              padding: listEntryPadding.copyWith(bottom: 5),
              child: Row(
                children: [
                  ListSerialNoText(index: index),
                  ListEntryItem(text: _viewModel.visibleUnreadMessagesList[index].name!, maxLines: 1,),
                  ListEntryItem(text: _viewModel.visibleUnreadMessagesList[index].email, maxLines: 1,),
                  ListEntryItem(text: DateFormat('dd/MM/yyyy').format(_viewModel.visibleUnreadMessagesList[index].createdAt!),),
                  ListActionsButtons(
                    includeDelete: false,
                    includeEdit: false,
                    includeView: true,
                    onViewPressed: () => _viewModel.showMessageDetailsDialog(_viewModel.visibleUnreadMessagesList[index]),
                  )
                ],
              ),
            );
          }),
          ),
        ),
      ],
    );
  }
}
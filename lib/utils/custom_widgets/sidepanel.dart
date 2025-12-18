import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/images_paths.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

import '../constants.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({
    super.key,
    required this.scrollController,
    required this.selectedItemIndex,
    this.args
  });

  final int selectedItemIndex;
  final Map<String, dynamic>? args;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
      width: MediaQuery.sizeOf(context).width * 0.2,
      decoration: BoxDecoration(
          color: primaryWhite
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SidePanelHeading(text: 'Home', icon: CupertinoIcons.home,),
            _SidePanelItem(text: 'Banner', routeName: Routes.homeBanner, itemIndex: 0, args: args,),
            _SidePanelItem(text: 'Content', routeName: Routes.homeContent , itemIndex: 1, args: args,),
            _SidePanelItem(text: 'Timer Banner', routeName: Routes.homeTimerBanner , itemIndex: 2, args: args,),
            _SidePanelHeading(text: 'About', icon: CupertinoIcons.info_circle,),
            _SidePanelItem(text: 'Banner', routeName: Routes.about, itemIndex: 3, args: args,),
            _SidePanelItem(text: 'Content', routeName: Routes.contact, itemIndex: 4, args: args,),
            _SidePanelHeading(text: 'Innovation', image: ImagesPaths.innovation),
            _SidePanelItem(text: 'Banner', routeName: Routes.about, itemIndex: 5, args: args,),
            _SidePanelItem(text: 'Content', routeName: Routes.contact, itemIndex: 6, args: args,),
            _SidePanelHeading(text: 'Responsibility', icon: Icons.energy_savings_leaf_outlined,),
            _SidePanelItem(text: 'Banner', routeName: Routes.about, itemIndex: 7, args: args,),
            _SidePanelItem(text: 'Content', routeName: Routes.contact, itemIndex: 8, args: args,),
            _SidePanelItem(text: 'Support', routeName: Routes.support, itemIndex: 9, args: args,),
            // _SidePanelItem(text: lang_key.servicemenList.tr, routeName: Routes.servicemenList, selectedItemIndex: selectedItemIndex, icon: Icons.list_alt_rounded, args: args,),
            // _SidePanelItem(text: lang_key.suspendedServiceMen.tr, routeName: Routes.suspendedServicemanList, selectedItemIndex: selectedItemIndex, icon: Icons.person_off_outlined, args: args,),
            // _SidePanelHeading(text: lang_key.serviceManagement.tr),
            // _SidePanelItem(text: lang_key.servicesList.tr, routeName: Routes.servicesList, selectedItemIndex: selectedItemIndex, image: ImagesPaths.servicesList, args: args,),
            // _SidePanelItem(text: lang_key.subServicesList.tr, routeName: Routes.subServicesList, selectedItemIndex: selectedItemIndex, image: ImagesPaths.subServicesList, args: args,),
            // _SidePanelItem(text: lang_key.itemsList.tr, routeName: Routes.itemsList, selectedItemIndex: selectedItemIndex, image: ImagesPaths.item, args: args,),
            // _SidePanelHeading(text: lang_key.withdraws.tr),
            // _SidePanelItem(text: lang_key.methods.tr, routeName: Routes.withdrawMethods, selectedItemIndex: selectedItemIndex, icon: Icons.type_specimen_outlined, args: args,),
            // _SidePanelItem(text: lang_key.requests.tr, routeName: Routes.withdrawRequests, selectedItemIndex: selectedItemIndex, icon: CupertinoIcons.money_dollar, args: args,),
            // _SidePanelHeading(text: lang_key.settings.tr),
            // _SidePanelItem(text: lang_key.businessSetup.tr, routeName: Routes.businessSetup, selectedItemIndex: selectedItemIndex, icon: Icons.business, args: args,),
          ],
        ),
      ),
    );
  }
}

/// Heading text in side panel
class _SidePanelHeading extends StatelessWidget {
  const _SidePanelHeading({
    required this.text,
    this.image,
    this.icon
  }) : assert(icon != null || image != null, 'Either provide icon or image'),
  assert(icon == null || image == null, 'Cannot provide both icon and image');

  final String text;
  final String? image;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, right: 5),
      child: ListTile(
        minLeadingWidth: 1,
        trailing: icon != null ? Icon(
          icon!,
          size: 25,
          color: primaryGrey,
        ) : Image.asset(
          image!,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: primaryGrey,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    );
  }
}

/// Selectable / Pressable text item in side panel
class _SidePanelItem extends StatelessWidget {
  const _SidePanelItem({
    required this.text,
    required this.routeName,
    required this.itemIndex,
    this.args,
  });

  final String text;
  final int itemIndex;
  final String routeName;
  final Map<String, dynamic>? args;

  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: GlobalVariables.selectedSidePanelItemIndex.value == itemIndex ? primaryBlue : Colors.transparent
          ),
          child: ListTile(
            minVerticalPadding: 0,
            minTileHeight: 40,
            onTap: () => Get.offAllNamed(routeName, arguments: args,),
            title: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 15.5,
                color: GlobalVariables.selectedSidePanelItemIndex.value == itemIndex ? primaryWhite : primaryGrey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

            ),
          ),
      ),
    );
  }
}
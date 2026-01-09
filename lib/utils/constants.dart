import 'package:flutter/material.dart';
import 'package:mts_website_admin_panel/models/sidepanel_item_data.dart';
import 'package:mts_website_admin_panel/utils/routes.dart';

/// Colors

const primaryWhite = Colors.white;
const primaryBlack = Colors.black;
const primaryBlue = Color(0xff0059B3);
const panelBackground = Color(0xfff6f6f6);
const primaryDullYellow = Color(0xffe4b61a);
const errorRed = Colors.red;
Color primaryGrey = Colors.grey.shade400;
Color secondaryGrey = Colors.grey.shade200;
Color primaryGrey20 = primaryGrey.withValues(alpha: 0.2);
Color primaryGrey50 = primaryGrey.withValues(alpha: 0.5);
Color pageBannerSubtitleTextColor = Color(0xff05DDFB);
Color primaryDarkBlue = Color(0xff00345C);
const primaryPreviewButtonOrange = Colors.deepOrangeAccent;

/// Section Container height ///
const double kSectionContainerHeightValue = 90.0;
/// Section Container height end ///

/// Container Decorations
  /// Border Radius
  BorderRadius kContainerBorderRadius = BorderRadius.circular(12);

  /// Border
  Border kContainerBorderSide = Border.all(
    color: primaryGrey.withValues(alpha: 0.5),
    width: 0.8
  );

  /// Standard Container BoxDecoration
  BoxDecoration kContainerBoxDecoration = BoxDecoration(
    color: primaryWhite,
    borderRadius: kContainerBorderRadius,
    border: kContainerBorderSide
  );
/// Container Decorations End ///

/// Constant Paddings ///
const EdgeInsets basePaddingForScreens = EdgeInsets.all(20);
const EdgeInsets basePaddingForContainers = EdgeInsets.all(20);
const EdgeInsets listEntryPadding = EdgeInsets.only(left: 18.5, bottom: 5);
/// Constant Paddings End ///

/// Input Decorations ///
OutlineInputBorder kEnabledBorder = OutlineInputBorder(
  borderRadius: kContainerBorderRadius,
  borderSide: BorderSide(
    color: primaryGrey50,
    width: 0.8
  )
);

OutlineInputBorder kFocusedBorder = kEnabledBorder.copyWith(
  borderSide: kEnabledBorder.borderSide.copyWith(
    width: 1.5
  )
);

OutlineInputBorder kDisabledBorder = kEnabledBorder.copyWith(
  borderSide: kEnabledBorder.borderSide.copyWith(
    color: primaryGrey20,
    width: 1
  )
);

OutlineInputBorder kErrorBorder = kEnabledBorder.copyWith(
  borderSide: kEnabledBorder.borderSide.copyWith(
    color: errorRed
  )
);

OutlineInputBorder kFocusedErrorBorder = kFocusedBorder.copyWith(
  borderSide: kFocusedBorder.borderSide.copyWith(
    color: errorRed
  )
);

/// Input Decorations End ///

/// Google Maps constant values ///
// CameraPosition initialCameraPosition = CameraPosition(
//     target: LatLng(43.651774, -79.384573),
//   zoom: mapsZoomLevel
// );

double mapsZoomLevel = 14.0;
/// Google Maps constant values End ///

/// Order Status Enum
enum OrderStatus {pending, accepted, ongoing, completed, cancelled, disputed}
/// Order Status Enum End ///

/// New Method Input Field Type ///
enum WithdrawMethodFieldType {text, number, email}
/// New Method Input Field Type End ///

/// User statuses ///
enum UserStatuses {pending, active, inactive, declined, suspended}
/// User statuses End ///

/// Order Type Enum
enum OrderType {normal, quick, urgent}

/// Months list
const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

/// Sidepanel animation variables
Duration sidePanelAnimationDuration = Duration(milliseconds: 300);
Curve sidePanelAnimationCurve = Curves.easeIn;

/// Sidepanel scroll positions
List<SidePanelItemData> sidePanelItemsData = [
  SidePanelItemData(routeName: Routes.homeBanner, scrollPosition: 0.0, sidePanelItemIndex: 0),
  SidePanelItemData(routeName: Routes.homeContent, scrollPosition: 0.0, sidePanelItemIndex: 1),
  SidePanelItemData(routeName: Routes.homeProjects, scrollPosition: 0.0, sidePanelItemIndex: 2),
  SidePanelItemData(routeName: Routes.homeProjectsEdit, scrollPosition: 0.0, sidePanelItemIndex: 2), /// Index is deliberately kept same
  SidePanelItemData(routeName: Routes.homeTimerBanner, scrollPosition: 0.0, sidePanelItemIndex: 3),
  SidePanelItemData(routeName: Routes.aboutBanner, scrollPosition: 220.0, sidePanelItemIndex: 4),
  SidePanelItemData(routeName: Routes.aboutContent, scrollPosition: 220.0, sidePanelItemIndex: 5),
  SidePanelItemData(routeName: Routes.innovationBanner, scrollPosition: 300.0, sidePanelItemIndex: 6),
  SidePanelItemData(routeName: Routes.innovationContent, scrollPosition: 300.0, sidePanelItemIndex: 7),
  SidePanelItemData(routeName: Routes.innovationEditProject, scrollPosition: 300.0, sidePanelItemIndex: 7), /// Index is deliberately kept same
  SidePanelItemData(routeName: Routes.responsibilityBanner, scrollPosition: 160.0, sidePanelItemIndex: 8),
  SidePanelItemData(routeName: Routes.responsibilityContent, scrollPosition: 160.0, sidePanelItemIndex: 9),
  SidePanelItemData(routeName: Routes.responsibilityProjects, scrollPosition: 160.0, sidePanelItemIndex: 10),
  SidePanelItemData(routeName: Routes.contactBanner, scrollPosition: 180.0, sidePanelItemIndex: 11),
  SidePanelItemData(routeName: Routes.contactContent, scrollPosition: 180.0, sidePanelItemIndex: 12),
  SidePanelItemData(routeName: Routes.footer, scrollPosition: 180.0, sidePanelItemIndex: 13),
  // {Routes.homeBanner: 0.0},
  // {Routes.homeContent: 0.0},
  // {Routes.homeTimerBanner: 0.0},
  // {Routes.about: 90},
  // {Routes.innovation: 90},
  // {Routes.contact: 170},
  // {Routes.messagesList: 260},
];

/// Container names for Local Storage
String userDataContainerName = 'admin_data';
String languageContainerName = 'language';

/// Keys for storing data in the local storage 
const String adminDetailsKey = 'admin_details';
const String languageCodeKey = 'language_key';
const String tokenKey = 'token';
const String isLoggedInKey = 'isLoggedIn';
const String isNotFirstTimeKey = 'isNotFirstTime';
const String projectDetailsKey = 'projectDetails';
const String packageDetailsKey = 'packageDetails';

bool isSmallScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 750;
}

/// Max Length values for fields
const int mediumDescription = 80;
const int shortDescription = 60;

const int mediumTitle = 50;
const int shortTitle = 30;

const int mediumSubtitle = 60;
const int shortSubtitle = 40;

const int shortMetricHeading = 15;
const int mediumMetricHeading = 20;

const int shortMetricValue = 5;
const int mediumMetricValue = 10;
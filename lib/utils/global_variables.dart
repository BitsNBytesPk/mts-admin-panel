import 'package:get/get.dart';
import 'package:mts_website_admin_panel/models/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalVariables {

  /// Profile Dropdown visibility variable
  static RxBool openProfileDropdown = false.obs;

  /// Loader visibility variable
  static RxBool showLoader = false.obs;

  /// JWT token
  static String token = '';

  static RxString logoUrl = ''.obs;

  static RxInt unreadMessagesCount = 0.obs;

  /// Variable to control the lists height in UI
  static RxDouble listHeight = 0.0.obs;

  static Rx<Admin> userDetails = Admin().obs;

  static SharedPreferences? prefs;

  static RxInt selectedSidePanelItemIndex = 0.obs;
}
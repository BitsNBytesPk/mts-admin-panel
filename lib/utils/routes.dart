import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/about/banner/about_banner_view.dart';
import 'package:mts_website_admin_panel/screens/about/content/about_content_view.dart';
import 'package:mts_website_admin_panel/screens/home/content/home_content_view.dart';
import 'package:mts_website_admin_panel/screens/messages/messages_list_view.dart';
import 'package:mts_website_admin_panel/screens/settings/settings_view.dart';

import '../screens/about/about_view.dart';
import '../screens/auth/login/login_view.dart';
import '../screens/contact/contact_view.dart';
import '../screens/home/banner/home_banner_view.dart';
import '../screens/home/timer_banner/timer_banner_view.dart';

class Routes {

  // static const initRoute = '/initRoute';
  static const login = '/login';
  static const homeBanner = '/homeBanner';
  static const homeContent = '/homeContent';
  static const homeTimerBanner = '/homeTimerBanner';
  static const aboutBanner = '/aboutBanner';
  static const aboutContent = '/aboutContent';
  static const innovation = '/innovation';
  static const contact = '/contact';
  static const editPackage = '/editPackage';
  static const messagesList = '/messagesList';
  static const support = '/support';

  static final pages = [

    // GetPage(name: initRoute, page: () => SplashView(),),
    GetPage(name: login, page: () => LoginView()),
    GetPage(name: homeBanner, page: () => HomeBannerView()),
    GetPage(name: homeContent, page: () => HomeContentView()),
    GetPage(name: homeTimerBanner, page: () => HomeTimerBannerView()),
    GetPage(name: aboutBanner, page: () => AboutBannerView()),
    GetPage(name: aboutContent, page: () => AboutContentView()),
    // GetPage(name: innovation, page: () => EditProjectView()),
    GetPage(name: contact, page: () => ContactView()),
    GetPage(name: messagesList, page: () => MessagesListView()),
    // GetPage(name: editPackage, page: () => EditPackageView()),
    GetPage(name: support, page: () => SettingsView()),
  ];
}
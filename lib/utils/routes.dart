import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/about/banner/about_banner_view.dart';
import 'package:mts_website_admin_panel/screens/about/content/about_content_view.dart';
import 'package:mts_website_admin_panel/screens/banner_preview/banner_preview_view.dart';
import 'package:mts_website_admin_panel/screens/home/content/home_content_view.dart';
import 'package:mts_website_admin_panel/screens/home/home_project_preview/home_project_preview_view.dart';
import 'package:mts_website_admin_panel/screens/home/projects/projects_listing_view.dart';
import 'package:mts_website_admin_panel/screens/messages/messages_list_view.dart';
import 'package:mts_website_admin_panel/screens/responsibility/projects_listing/responsibility_projects_listing_view.dart';
import 'package:mts_website_admin_panel/screens/responsibility/responsibility_project_preview/responsibility_project_preview_view.dart';
import 'package:mts_website_admin_panel/screens/settings/settings_view.dart';
import '../../screens/innovation/banner/innovation_banner_view.dart';
import '../../screens/innovation/content/innovation_content_view.dart';


import '../screens/auth/login/login_view.dart';
import '../screens/contact/contact_view.dart';
import '../screens/home/banner/home_banner_view.dart';
import '../screens/home/timer_banner/timer_banner_view.dart';
import '../screens/responsibility/banner/responsibility_banner_view.dart';
import '../screens/responsibility/content/responsibility_content_view.dart';

class Routes {

  // static const initRoute = '/initRoute';
  static const login = '/login';

  static const homeBanner = '/homeBanner';
  static const homeContent = '/homeContent';
  static const homeTimerBanner = '/homeTimerBanner';
  static const homeProjects = '/homeProjects';
  static const homeProjectPreview = '/homeProjectPreview';

  static const aboutBanner = '/aboutBanner';
  static const aboutContent = '/aboutContent';

  static const innovationBanner = '/innovationBanner';
  static const innovationContent = '/innovationContent';

  static const responsibilityBanner = '/responsibilityBanner';
  static const responsibilityContent = '/responsibilityContent';
  static const responsibilityProjects = '/responsibilityProjects';
  static const responsibilityProjectPreview = '/responsibilityProjectPreview';

  static const contact = '/contact';
  static const editPackage = '/editPackage';
  static const messagesList = '/messagesList';
  static const support = '/support';
  static const bannerPreview = '/bannerPreview';

  static final pages = [

    // GetPage(name: initRoute, page: () => SplashView(),),
    GetPage(name: login, page: () => LoginView()),

    GetPage(name: homeBanner, page: () => HomeBannerView(), maintainState: false),
    GetPage(name: homeContent, page: () => HomeContentView(), maintainState: false),
    GetPage(name: homeTimerBanner, page: () => HomeTimerBannerView()),
    GetPage(name: homeProjects, page: () => HomeProjectsListingView()),
    GetPage(name: homeProjectPreview, page: () => HomeProjectPreviewView(), maintainState: false),

    GetPage(name: aboutBanner, page: () => AboutBannerView(), maintainState: false),
    GetPage(name: aboutContent, page: () => AboutContentView()),

    GetPage(name: innovationBanner, page: () => InnovationBannerView(), maintainState: false),
    GetPage(name: innovationContent, page: () => InnovationContentView()),

    GetPage(name: responsibilityBanner, page: () => ResponsibilityBannerView(), maintainState: false),
    GetPage(name: responsibilityContent, page: () => ResponsibilityContentView()),
    GetPage(name: responsibilityProjects, page: () => ResponsibilityProjectsListingView()),
    GetPage(name: responsibilityProjectPreview, page: () => ResponsibilityProjectPreviewView(), maintainState: false),

    GetPage(name: contact, page: () => ContactView()),
    GetPage(name: messagesList, page: () => MessagesListView()),
    // GetPage(name: editPackage, page: () => EditPackageView()),
    GetPage(name: support, page: () => SettingsView()),
    GetPage(name: bannerPreview, page: () => BannerPreviewView(), maintainState: false),
  ];
}
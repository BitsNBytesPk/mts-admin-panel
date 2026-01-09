import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/about/banner/about_banner_view.dart';
import 'package:mts_website_admin_panel/screens/about/content/about_content_view.dart';
import 'package:mts_website_admin_panel/screens/banner_preview/banner_preview_view.dart';
import 'package:mts_website_admin_panel/screens/contact/banner/contact_banner_view.dart';
import 'package:mts_website_admin_panel/screens/contact/content/contact_content_view.dart';
import 'package:mts_website_admin_panel/screens/home/content/home_content_view.dart';
import 'package:mts_website_admin_panel/screens/home/home_project_preview/home_project_preview_view.dart';
import 'package:mts_website_admin_panel/screens/home/projects/edit_project/edit_project_view.dart';
import 'package:mts_website_admin_panel/screens/home/projects/projects_listing/projects_listing_view.dart';
import 'package:mts_website_admin_panel/screens/innovation/innovation_edit_project/innovation_edit_project_view.dart';
import 'package:mts_website_admin_panel/screens/innovation/innovation_project_preview/innovation_project_preview_view.dart';
import 'package:mts_website_admin_panel/screens/messages/messages_list_view.dart';
import 'package:mts_website_admin_panel/screens/responsibility/projects_listing/responsibility_projects_listing_view.dart';
import 'package:mts_website_admin_panel/screens/responsibility/responsibility_project_preview/responsibility_project_preview_view.dart';
import 'package:mts_website_admin_panel/screens/shared_data/footer/footer_view.dart';
import '../../screens/innovation/banner/innovation_banner_view.dart';
import '../../screens/innovation/content/innovation_content_view.dart';


import '../screens/auth/login/login_view.dart';
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
  static const homeProjectsEdit = '/homeProjectEdit';
  static const homeProjectPreview = '/homeProjectPreview';

  static const aboutBanner = '/aboutBanner';
  static const aboutContent = '/aboutContent';

  static const innovationBanner = '/innovationBanner';
  static const innovationContent = '/innovationContent';
  static const innovationEditProject = '/innovationEditProject';
  static const innovationProjectPreview = '/innovationProjectPreview';

  static const responsibilityBanner = '/responsibilityBanner';
  static const responsibilityContent = '/responsibilityContent';
  static const responsibilityProjects = '/responsibilityProjects';
  static const responsibilityProjectPreview = '/responsibilityProjectPreview';

  static const footer = '/footer';

  static const contactBanner = '/contactBanner';
  static const contactContent = '/contactContent';

  static const editPackage = '/editPackage';
  static const messagesList = '/messagesList';
  static const support = '/support';
  static const bannerPreview = '/bannerPreview';

  static final pages = [

    // GetPage(name: initRoute, page: () => SplashView(),),
    GetPage(name: login, page: () => LoginView()),

    GetPage(name: homeBanner, page: () => HomeBannerView(), maintainState: false),
    GetPage(name: homeContent, page: () => HomeContentView(), maintainState: false),
    GetPage(name: homeTimerBanner, page: () => HomeTimerBannerView(), maintainState: false),
    GetPage(name: homeProjects, page: () => HomeProjectsListingView(), maintainState: false),
    GetPage(name: homeProjectsEdit, page: () => HomeProjectEditView(), maintainState: false),
    GetPage(name: homeProjectPreview, page: () => HomeProjectPreviewView(), maintainState: false),

    GetPage(name: aboutBanner, page: () => AboutBannerView(), maintainState: false),
    GetPage(name: aboutContent, page: () => AboutContentView(), maintainState: false),

    GetPage(name: innovationBanner, page: () => InnovationBannerView(), maintainState: false),
    GetPage(name: innovationContent, page: () => InnovationContentView(), maintainState: false),
    GetPage(name: innovationEditProject, page: () => InnovationEditProjectView(), maintainState: false),
    GetPage(name: innovationProjectPreview, page: () => InnovationProjectPreviewView(), maintainState: false),

    GetPage(name: responsibilityBanner, page: () => ResponsibilityBannerView(), maintainState: false),
    GetPage(name: responsibilityContent, page: () => ResponsibilityContentView(), maintainState: false),
    GetPage(name: responsibilityProjects, page: () => ResponsibilityProjectsListingView(), maintainState: false),
    GetPage(name: responsibilityProjectPreview, page: () => ResponsibilityProjectPreviewView(), maintainState: false),

    GetPage(name: contactBanner, page: () => ContactBannerView(), maintainState: false),
    GetPage(name: contactContent, page: () => ContactContentView(), maintainState: false),

    GetPage(name: footer, page: () => FooterView(), maintainState: false),

    GetPage(name: messagesList, page: () => MessagesListView(), maintainState: false),
    GetPage(name: bannerPreview, page: () => BannerPreviewView(), maintainState: false),
  ];
}
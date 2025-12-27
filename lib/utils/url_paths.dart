class Urls {

  static const testEnvironment = 'https://mts-website-backend.onrender.com';
  static const prodEnvironment = '';

  static const baseURL = testEnvironment;

  static const _pagesBaseUrl = '/admin/pages';
  // static const _homeBaseUrl = '/home';
  static const _projectBaseUrl = '/projects';
  static const _messagesBaseUrl = '/messages';
  static const _packagesBaseUrl = '/packages';
  static const _dashboardBaseUrl = '/home';
  static const _authBaseUrl = '/auth';
  static const _settingsBaseUrl = '/settings';

  static const String portfolioData = '$_settingsBaseUrl/personal_data';

  static String updatePortfolioData(String id) {
    return '$_settingsBaseUrl/personal_data/$id';
  }

  static const String downloadCv = '$_settingsBaseUrl/personal_data/cv';

  /// Auth
    /// Login
    static const String login = '/admin$_authBaseUrl/login';
    static const String getUserProfile = '$_authBaseUrl/user_profile';

 /// Auth End ///

  /// Home
  static const String homeData = '$_pagesBaseUrl/home';
  /// Home End

  /// About ///
  static const String aboutData = '$_pagesBaseUrl/about';
  /// About End ///

  /// Shared Data ///
  static const String sharedData = '$_pagesBaseUrl/shared';
  /// Shared Data End ///

  /// Innovation ///
  static const String innovationData = '$_pagesBaseUrl/innovation';
  /// Innovation End ///

  /// Project Setup
  static String editProject(String id) {
    return '$_projectBaseUrl/$id';
  }

  static String deleteProject(String id) {
    return '$_projectBaseUrl/$id';
  }

  static const String addNewProject = '$_projectBaseUrl/add';
  static const String getAllProjects = '$_projectBaseUrl/get';

  /// Messages ///
    /// Messages List ///
    static const String getMessages = '$_messagesBaseUrl/get';
    static const String getMessagesStats = '$_messagesBaseUrl/stats';

    static String changeMessageStatus(String id) {
      return '$_messagesBaseUrl/change_status/$id';
    }

  /// Messages End ///

  /// Packages Management ///
    /// Packages List ///
    static const String getPackages = '$_packagesBaseUrl/get';
    static const String addPackage = '$_packagesBaseUrl/add';

    static String editPackage(String id) {
      return '$_packagesBaseUrl/$id';
    }

    static String deletePackage(String id) {
      return '$_packagesBaseUrl/$id';
    }
    /// Packages List End ///

  /// Dashboard ///

  static const String getRecentMessages = '$_dashboardBaseUrl/messages/get';

  static const String getAppsStats = '$_dashboardBaseUrl/projects/stats';
  /// Dashboard End ///
}
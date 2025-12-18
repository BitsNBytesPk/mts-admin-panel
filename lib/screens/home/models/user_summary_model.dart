class AppsSummary {

  int? totalDesktopApps;
  int? totalWebApps;
  int? totalApps;
  int? totalMobileApps;
  int? totalPackages;
  
  AppsSummary({
    this.totalDesktopApps,
    this.totalWebApps,
    this.totalApps,
    this.totalMobileApps,
    this.totalPackages,
  });

  AppsSummary.fromJson(Map<String, dynamic> json) {
    totalDesktopApps = json['total_desktop_apps'] ?? 0;
    totalWebApps = json['total_web_apps'] ?? 0;
    totalApps = json['total_apps'] ?? 0;
    totalMobileApps = json['total_mobile_apps'] ?? 0;
    totalPackages = json['total_packages'] ?? 0;
  }
}
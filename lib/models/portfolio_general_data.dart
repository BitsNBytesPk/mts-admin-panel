class PortfolioGeneralData {

  String? id;
  String? portfolioName;
  String? title;
  String? displayImage;
  String? cvLink;
  String? githubLink;
  String? linkedinLink;
  String? email;
  String? copyrightsText;
  String? footerText;
  String? aboutMe;
  String? aboutMeSecondaryDesc;
  String? summaryText;

  PortfolioGeneralData({
    this.id,
    this.portfolioName,
    this.title,
    this.displayImage,
    this.cvLink,
    this.githubLink,
    this.linkedinLink,
    this.email,
    this.copyrightsText,
    this.footerText,
    this.aboutMe,
    this.summaryText,
    this.aboutMeSecondaryDesc
  });

  PortfolioGeneralData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    portfolioName = json['name'];
    title = json['title'];
    displayImage = json['display_image'];
    cvLink = json['cv_link'];
    githubLink = json['github_link'];
    linkedinLink = json['linkedin_link'];
    email = json['email'];
    copyrightsText = json['copyrights_text'];
    footerText = json['footer_text'];
    aboutMe = json['about_me'];
    summaryText = json['summary_text'];
    aboutMeSecondaryDesc = json['about_me_secondary_desc'];

  }
}
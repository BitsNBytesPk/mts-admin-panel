import 'dart:typed_data';

class PageBannerModel {

  String? title;
  String? subtitle;
  String? description;
  String? ctaText;
  Uint8List? newBanner;
  String? uploadedBanner;

  PageBannerModel({
    this.title,
    this.subtitle,
    this.description,
    this.ctaText,
    this.newBanner,
    this.uploadedBanner,
  });

  PageBannerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    ctaText = json['ctaText'];
    newBanner = json['newBanner'];
    uploadedBanner = json['uploadedBanner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['description'] = description;
    data['ctaText'] = ctaText;
    data['newBanner'] = newBanner;
    data['uploadedBanner'] = uploadedBanner;
    return data;
  }
}
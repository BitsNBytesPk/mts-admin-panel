import 'package:flutter/material.dart' show Color;

import '../helpers/convert_string_to_color.dart';
class Project {

  String? id;
  String? name;
  String? desc;
  bool? status;
  String? projectStatus;
  String? projectType;
  List<String>? keyFeatures;
  List<String>? techStack;
  Color? projectColor;
  String? iosLink;
  String? androidLink;
  String? githubLink;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  Project({
    this.id,
    this.status,
    this.createdAt,
    this.name,
    this.desc,
    this.keyFeatures,
    this.techStack,
    this.projectColor,
    this.iosLink,
    this.androidLink,
    this.githubLink,
    this.projectStatus,
    this.projectType,
    this.updatedAt,
    this.image
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    status = json['status'] == 0 ? false : true;
    name = json['name'];
    desc = json['description'];
    projectStatus = json['project_status'];
    projectType = json['project_type'];
    keyFeatures = json['key_features'].cast<String>();
    techStack = json['tech_stack'].cast<String>();
    if(json['project_color'] != null) {
      projectColor = parseColorString(json['project_color']);
    }
    iosLink = json['ios_link'];
    androidLink = json['android_link'];
    githubLink = json['github_link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = desc;
    data['status'] = status != null && status! ? 1 : 0;
    data['key_features'] = keyFeatures;
    data['tech_stack'] = techStack;
    data['project_color'] = projectColor.toString();
    data['ios_link'] = iosLink;
    data['android_link'] = androidLink;
    data['github_link'] = githubLink;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    data['project_type'] = projectType;
    data['project_status'] = projectStatus;
    return data;
  }
}
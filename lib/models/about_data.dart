class AboutData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  AboutData({this.sId,
    this.content,
    this.createdAt,
    this.slug,
    this.status,
    this.title,
    this.updatedAt,
    this.version});

  AboutData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
    createdAt = json['createdAt'];
    slug = json['slug'];
    status = json['status'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['createdAt'] = createdAt;
    data['slug'] = slug;
    data['status'] = status;
    data['title'] = title;
    data['updatedAt'] = updatedAt;
    data['version'] = version;
    return data;
  }
}

class Content {
  Hero? hero;
  List<AchievementsItems>? timelineItems;
  List<ValuesItems>? valuesItems;

  Content({
    this.hero,
    this.timelineItems,
    this.valuesItems
  });

  Content.fromJson(Map<String, dynamic> json) {
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    
    if(json['timeline'] != null && json['timeline']['items'] != null) {
      timelineItems = <AchievementsItems>[];
      json['timeline']['items'].forEach((v) {
        timelineItems!.add(AchievementsItems.fromJson(v));
      });
    }
    
    if(json['values'] != null && json['values']['items'] != null) {
      valuesItems = [];
      json['values']['items'].forEach((v) {
        valuesItems!.add(ValuesItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (timelineItems != null) {
      data['timeline'] = timelineItems!.map((v) => v.toJson()).toList();
    }
    if (valuesItems != null) {
      data['values'] = valuesItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hero {
  String? backgroundImage;
  String? backgroundVideo;
  String? ctaText;
  String? description;
  String? height;
  String? subtitle;
  String? title;

  Hero({
    this.backgroundImage,
    this.backgroundVideo,
    this.ctaText,
    this.description,
    this.height,
    this.subtitle,
    this.title
  });

  Hero.fromJson(Map<String, dynamic> json) {
    backgroundImage = json['backgroundImage'];
    backgroundVideo = json['backgroundVideo'];
    ctaText = json['ctaText'];
    description = json['description'];
    height = json['height'];
    subtitle = json['subtitle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backgroundImage'] = backgroundImage;
    data['backgroundVideo'] = backgroundVideo;
    data['ctaText'] = ctaText;
    data['description'] = description;
    data['height'] = height;
    data['subtitle'] = subtitle;
    data['title'] = title;
    return data;
  }
}

class ValuesItems {
  String? description;
  String? icon;
  String? title;

  ValuesItems({this.description, this.icon, this.title});

  ValuesItems.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    icon = json['icon'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['icon'] = icon;
    data['title'] = title;
    return data;
  }
}

class AchievementsItems {
  String? description;
  String? year;
  String? title;

  AchievementsItems({this.description, this.year, this.title});

  AchievementsItems.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    year = json['year'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['year'] = year;
    data['title'] = title;
    return data;
  }
}
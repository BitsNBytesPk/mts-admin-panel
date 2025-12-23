class HomeData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  HomeData({
    this.sId,
    this.content,
    this.createdAt,
    this.slug,
    this.status,
    this.title,
    this.updatedAt,
    this.version
  });

  HomeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
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
  FooterCta? footerCta;
  Hero? hero;
  Innovations? innovations;
  Mission? mission;
  ResponsibilityTeaser? responsibilityTeaser;

  Content({
    this.footerCta,
    this.hero,
    this.innovations,
    this.mission,
    this.responsibilityTeaser
  });

  Content.fromJson(Map<String, dynamic> json) {
    footerCta = json['footerCta'] != null
        ? FooterCta.fromJson(json['footerCta'])
        : null;
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    innovations = json['innovations'] != null
        ? Innovations.fromJson(json['innovations'])
        : null;
    mission =
    json['mission'] != null ? Mission.fromJson(json['mission']) : null;
    responsibilityTeaser = json['responsibilityTeaser'] != null
        ? ResponsibilityTeaser.fromJson(json['responsibilityTeaser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (footerCta != null) {
      data['footerCta'] = footerCta!.toJson();
    }
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (innovations != null) {
      data['innovations'] = innovations!.toJson();
    }
    if (mission != null) {
      data['mission'] = mission!.toJson();
    }
    if (responsibilityTeaser != null) {
      data['responsibilityTeaser'] = responsibilityTeaser!.toJson();
    }
    return data;
  }
}

class FooterCta {
  String? description;
  PrimaryCta? primaryCta;
  PrimaryCta? secondaryCta;
  String? title;

  FooterCta({this.description, this.primaryCta, this.secondaryCta, this.title});

  FooterCta.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    primaryCta = json['primaryCta'] != null
        ? PrimaryCta.fromJson(json['primaryCta'])
        : null;
    secondaryCta = json['secondaryCta'] != null
        ? PrimaryCta.fromJson(json['secondaryCta'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (primaryCta != null) {
      data['primaryCta'] = primaryCta!.toJson();
    }
    if (secondaryCta != null) {
      data['secondaryCta'] = secondaryCta!.toJson();
    }
    data['title'] = title;
    return data;
  }
}

class PrimaryCta {
  String? label;
  String? variant;

  PrimaryCta({this.label, this.variant});

  PrimaryCta.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['variant'] = variant;
    return data;
  }
}

class Hero {
  String? backgroundImage;
  String? backgroundVideo;
  String? ctaText;
  String? description;
  double? height;
  String? subtitle;
  String? title;

  Hero({this.backgroundImage,
        this.backgroundVideo,
        this.ctaText,
        this.description,
        this.height,
        this.subtitle,
        this.title});

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

class Innovations {
  List<Cards>? cards;
  String? heading;
  String? label;

  Innovations({this.cards, this.heading, this.label});

  Innovations.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(Cards.fromJson(v));
      });
    }
    heading = json['heading'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toJson()).toList();
    }
    data['heading'] = heading;
    data['label'] = label;
    return data;
  }
}

class Cards {
  String? backgroundImage;
  PrimaryCta? cta;
  String? description;
  String? icon;
  List<Metrics>? metrics;
  // Style? style;
  String? title;

  Cards(
      {this.backgroundImage,
        this.cta,
        this.description,
        this.icon,
        this.metrics,
        // this.style,
        this.title});

  Cards.fromJson(Map<String, dynamic> json) {
    backgroundImage = json['backgroundImage'];
    cta = json['cta'] != null ? PrimaryCta.fromJson(json['cta']) : null;
    description = json['description'];
    icon = json['icon'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
    // style = json['style'] != null ? Style.fromJson(json['style']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backgroundImage'] = backgroundImage;
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    data['description'] = description;
    data['icon'] = icon;
    if (metrics != null) {
      data['metrics'] = metrics!.map((v) => v.toJson()).toList();
    }
    // if (style != null) {
    //   data['style'] = style!.toJson();
    // }
    data['title'] = title;
    return data;
  }
}

class Metrics {
  String? highlightColor;
  String? label;
  String? value;

  Metrics({this.highlightColor, this.label, this.value});

  Metrics.fromJson(Map<String, dynamic> json) {
    highlightColor = json['highlightColor'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['highlightColor'] = highlightColor;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

// class Style {
//   String? accentColor;
//   String? glowColor;
//   String? gradientFrom;
//   String? gradientTo;
//
//   Style({this.accentColor, this.glowColor, this.gradientFrom, this.gradientTo});
//
//   Style.fromJson(Map<String, dynamic> json) {
//     accentColor = json['accentColor'];
//     glowColor = json['glowColor'];
//     gradientFrom = json['gradientFrom'];
//     gradientTo = json['gradientTo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['accentColor'] = accentColor;
//     data['glowColor'] = glowColor;
//     data['gradientFrom'] = gradientFrom;
//     data['gradientTo'] = gradientTo;
//     return data;
//   }
// }

class Mission {
  String? footnote;
  String? heading;
  String? label;
  String? subheading;

  Mission({this.footnote, this.heading, this.label, this.subheading});

  Mission.fromJson(Map<String, dynamic> json) {
    footnote = json['footnote'];
    heading = json['heading'];
    label = json['label'];
    subheading = json['subheading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['footnote'] = footnote;
    data['heading'] = heading;
    data['label'] = label;
    data['subheading'] = subheading;
    return data;
  }
}

class ResponsibilityTeaser {
  String? backgroundVideo;
  String? ctaText;
  String? description;
  String? heading;
  String? label;

  ResponsibilityTeaser(
      {this.backgroundVideo,
        this.ctaText,
        this.description,
        this.heading,
        this.label});

  ResponsibilityTeaser.fromJson(Map<String, dynamic> json) {
    backgroundVideo = json['backgroundVideo'];
    ctaText = json['ctaText'];
    description = json['description'];
    heading = json['heading'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backgroundVideo'] = backgroundVideo;
    data['ctaText'] = ctaText;
    data['description'] = description;
    data['heading'] = heading;
    data['label'] = label;
    return data;
  }
}
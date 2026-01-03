class ResponsibilityData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  ResponsibilityData({
    this.sId,
        this.content,
        this.createdAt,
        this.slug,
        this.status,
        this.title,
        this.updatedAt,
        this.version});

  ResponsibilityData.fromJson(Map<String, dynamic> json) {
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
  Commitment? commitment;
  PrimaryCta? cta;
  Deployments? deployments;
  Education? education;
  Hero? hero;
  Impact? impact;
  Partnerships? partnerships;
  Commitment? sustainability;

  Content(
      {this.commitment,
        this.cta,
        this.deployments,
        this.education,
        this.hero,
        this.impact,
        this.partnerships,
        this.sustainability});

  Content.fromJson(Map<String, dynamic> json) {
    commitment = json['commitment'] != null ? Commitment.fromJson(json['commitment']) : null;
    cta = json['cta'] != null ? PrimaryCta.fromJson(json['cta']) : null;
    deployments = json['deployments'] != null ? Deployments.fromJson(json['deployments']) : null;
    education = json['education'] != null ? Education.fromJson(json['education']) : null;
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    impact = json['impact'] != null ? Impact.fromJson(json['impact']) : null;
    partnerships = json['partnerships'] != null ? Partnerships.fromJson(json['partnerships']) : null;
    sustainability = json['sustainability'] != null ? Commitment.fromJson(json['sustainability']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (commitment != null) {
      data['commitment'] = commitment!.toJson();
    }
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    if (deployments != null) {
      data['deployments'] = deployments!.toJson();
    }
    if (education != null) {
      data['education'] = education!.toJson();
    }
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (impact != null) {
      data['impact'] = impact!.toJson();
    }
    if (partnerships != null) {
      data['partnerships'] = partnerships!.toJson();
    }
    if (sustainability != null) {
      data['sustainability'] = sustainability!.toJson();
    }
    return data;
  }
}

class Commitment {
  String? description;
  String? heading;
  String? label;
  List<Stats>? stats;

  Commitment({this.description, this.heading, this.label, this.stats});

  Commitment.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    heading = json['heading'];
    label = json['label'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['heading'] = heading;
    data['label'] = label;
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  String? icon;
  String? label;
  String? title;
  String? value;

  Stats({this.icon, this.label, this.title, this.value});

  Stats.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    label = json['label'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['label'] = label;
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}

class Cta {
  String? description;
  PrimaryCta? primaryCta;
  String? title;

  Cta({this.description, this.primaryCta, this.title});

  Cta.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    primaryCta = json['primaryCta'] != null
        ? PrimaryCta.fromJson(json['primaryCta'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    if (primaryCta != null) {
      data['primaryCta'] = primaryCta!.toJson();
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

class Deployments {
  List<ResponsibilityDeploymentCards>? cards;
  String? heading;
  String? label;

  Deployments({this.cards, this.heading, this.label});

  Deployments.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <ResponsibilityDeploymentCards>[];
      json['cards'].forEach((v) {
        cards!.add(ResponsibilityDeploymentCards.fromJson(v));
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

class ResponsibilityDeploymentCards {
  String? description;
  String? image;
  List<Metrics>? metrics;
  String? tag;
  String? title;

  ResponsibilityDeploymentCards({this.description, this.image, this.metrics, this.tag, this.title});

  ResponsibilityDeploymentCards.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    image = json['image'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
    tag = json['tag'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['image'] = image;
    if (metrics != null) {
      data['metrics'] = metrics!.map((v) => v.toJson()).toList();
    }
    data['tag'] = tag;
    data['title'] = title;
    return data;
  }
}

class Metrics {
  String? label;
  String? value;

  Metrics({this.label, this.value});

  Metrics.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class Education {
  PrimaryCta? cta;
  String? description;
  String? heading;
  String? image;
  String? label;

  Education({this.cta, this.description, this.heading, this.image, this.label});

  Education.fromJson(Map<String, dynamic> json) {
    cta = json['cta'] != null ? PrimaryCta.fromJson(json['cta']) : null;
    description = json['description'];
    heading = json['heading'];
    image = json['image'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    data['description'] = description;
    data['heading'] = heading;
    data['image'] = image;
    data['label'] = label;
    return data;
  }
}

class Hero {
  String? backgroundVideo;
  String? description;
  String? height;
  String? subtitle;
  String? title;

  Hero(
      {this.backgroundVideo,
        this.description,
        this.height,
        this.subtitle,
        this.title});

  Hero.fromJson(Map<String, dynamic> json) {
    backgroundVideo = json['backgroundVideo'];
    description = json['description'];
    height = json['height'];
    subtitle = json['subtitle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backgroundVideo'] = backgroundVideo;
    data['description'] = description;
    data['height'] = height;
    data['subtitle'] = subtitle;
    data['title'] = title;
    return data;
  }
}

class Impact {
  String? description;
  String? heading;
  String? label;
  List<Metrics>? metrics;

  Impact({this.description, this.heading, this.label, this.metrics});

  Impact.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    heading = json['heading'];
    label = json['label'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['heading'] = heading;
    data['label'] = label;
    if (metrics != null) {
      data['metrics'] = metrics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Partnerships {
  List<ResponsibilityPartnershipCards>? cards;
  String? description;
  String? heading;
  String? label;

  Partnerships({this.cards, this.description, this.heading, this.label});

  Partnerships.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <ResponsibilityPartnershipCards>[];
      json['cards'].forEach((v) {
        cards!.add(ResponsibilityPartnershipCards.fromJson(v));
      });
    }
    description = json['description'];
    heading = json['heading'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['heading'] = heading;
    data['label'] = label;
    return data;
  }
}

class ResponsibilityPartnershipCards {
  String? count;
  String? description;
  String? title;

  ResponsibilityPartnershipCards({this.count, this.description, this.title});

  ResponsibilityPartnershipCards.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['description'] = description;
    data['title'] = title;
    return data;
  }
}
//
// class ResponsibilityStats {
//   String? description;
//   String? percentage;
//   String? title;
//
//   ResponsibilityStats({this.description, this.percentage, this.title});
//
//   ResponsibilityStats.fromJson(Map<String, dynamic> json) {
//     description = json['description'];
//     percentage = json['percentage'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['description'] = description;
//     data['percentage'] = percentage;
//     data['title'] = title;
//     return data;
//   }
// }
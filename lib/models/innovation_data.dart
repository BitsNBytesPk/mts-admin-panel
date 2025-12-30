class InnovationData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  InnovationData(
      {this.sId,
        this.content,
        this.createdAt,
        this.slug,
        this.status,
        this.title,
        this.updatedAt,
        this.version});

  InnovationData.fromJson(Map<String, dynamic> json) {
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
  Cta? cta;
  Hero? hero;
  Overview? overview;
  List<Projects>? projects;

  Content({this.cta, this.hero, this.overview, this.projects});

  Content.fromJson(Map<String, dynamic> json) {
    cta = json['cta'] != null ? Cta.fromJson(json['cta']) : null;
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    overview = json['overview'] != null
        ? Overview.fromJson(json['overview'])
        : null;
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (overview != null) {
      data['overview'] = overview!.toJson();
    }
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
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

class Overview {
  String? description;
  String? heading;
  String? label;
  List<Stats>? stats;

  Overview({this.description, this.heading, this.label, this.stats});

  Overview.fromJson(Map<String, dynamic> json) {
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
  String? value;

  Stats({this.icon, this.label, this.value});

  Stats.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class Projects {
  Applications? applications;
  String? category;
  String? description;
  String? image;
  List<Metrics>? metrics;
  Technology? technology;
  String? title;

  Projects({
    this.applications,
    this.category,
    this.description,
    this.image,
    this.metrics,
    this.technology,
    this.title
  });

  Projects.fromJson(Map<String, dynamic> json) {
    applications = json['applications'] != null
        ? Applications.fromJson(json['applications'])
        : null;
    category = json['category'];
    description = json['description'];
    image = json['image'];
    if (json['metrics'] != null) {
      metrics = <Metrics>[];
      json['metrics'].forEach((v) {
        metrics!.add(Metrics.fromJson(v));
      });
    }
    technology = json['technology'] != null
        ? Technology.fromJson(json['technology'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (applications != null) {
      data['applications'] = applications!.toJson();
    }
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    if (metrics != null) {
      data['metrics'] = metrics!.map((v) => v.toJson()).toList();
    }
    if (technology != null) {
      data['technology'] = technology!.toJson();
    }
    data['title'] = title;
    return data;
  }
}

class Applications {
  String? heading;
  List<Items>? items;
  String? label;

  Applications({this.heading, this.items, this.label});

  Applications.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['label'] = label;
    return data;
  }
}

class Items {
  String? description;
  String? title;

  Items({this.description, this.title});

  Items.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
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

class Technology {
  String? heading;
  String? label;
  List<Steps>? steps;

  Technology({this.heading, this.label, this.steps});

  Technology.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    label = json['label'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    data['label'] = label;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  String? description;
  String? step;
  String? title;

  Steps({this.description, this.step, this.title});

  Steps.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    step = json['step'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['step'] = step;
    data['title'] = title;
    return data;
  }
}
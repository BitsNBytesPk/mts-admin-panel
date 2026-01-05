class SharedData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  SharedData(
      {this.sId,
        this.content,
        this.createdAt,
        this.slug,
        this.status,
        this.title,
        this.updatedAt,
        this.version});

  SharedData.fromJson(Map<String, dynamic> json) {
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
  Brand? brand;
  Contact? contact;
  Footer? footer;
  Leadership? leadership;
  Navigation? navigation;
  List<SocialLinks>? socialLinks;

  Content(
      {this.brand,
        this.contact,
        this.footer,
        this.leadership,
        this.navigation,
        this.socialLinks
      });

  Content.fromJson(Map<String, dynamic> json) {
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    contact =
    json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    footer =
    json['footer'] != null ? Footer.fromJson(json['footer']) : null;
    leadership = json['leadership'] != null
        ? Leadership.fromJson(json['leadership'])
        : null;
    navigation = json['navigation'] != null
        ? Navigation.fromJson(json['navigation'])
        : null;
    if (json['socialLinks'] != null) {
      socialLinks = <SocialLinks>[];
      json['socialLinks'].forEach((v) {
        socialLinks!.add(SocialLinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (footer != null) {
      data['footer'] = footer!.toJson();
    }
    if (leadership != null) {
      data['leadership'] = leadership!.toJson();
    }
    if (navigation != null) {
      data['navigation'] = navigation!.toJson();
    }
    if (socialLinks != null) {
      data['socialLinks'] = socialLinks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  String? logo;
  String? name;

  Brand({this.logo, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['name'] = name;
    return data;
  }
}

class Contact {
  List<String>? emails;
  List<Locations>? locations;
  List<String>? phones;

  Contact({this.emails, this.locations, this.phones});

  Contact.fromJson(Map<String, dynamic> json) {
    emails = json['emails'].cast<String>();
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    phones = json['phones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emails'] = emails;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    data['phones'] = phones;
    return data;
  }
}

class Locations {
  String? details;
  String? label;

  Locations({this.details, this.label});

  Locations.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['details'] = details;
    data['label'] = label;
    return data;
  }
}

class Footer {
  String? copyright;
  List<Legal>? legal;
  List<QuickLinks>? quickLinks;
  // List<Services>? services;
  String? tagline;

  Footer(
      {this.copyright,
        this.legal,
        this.quickLinks,
        // this.services,
        this.tagline});

  Footer.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    if (json['legal'] != null) {
      legal = <Legal>[];
      json['legal'].forEach((v) {
        legal!.add(Legal.fromJson(v));
      });
    }
    if (json['quickLinks'] != null) {
      quickLinks = <QuickLinks>[];
      json['quickLinks'].forEach((v) {
        quickLinks!.add(QuickLinks.fromJson(v));
      });
    }
    // if (json['services'] != null) {
    //   services = <Services>[];
    //   json['services'].forEach((v) {
    //     services!.add(Services.fromJson(v));
    //   });
    // }
    tagline = json['tagline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['copyright'] = copyright;
    if (legal != null) {
      data['legal'] = legal!.map((v) => v.toJson()).toList();
    }
    if (quickLinks != null) {
      data['quickLinks'] = quickLinks!.map((v) => v.toJson()).toList();
    }
    // if (services != null) {
      // data['services'] = services!.map((v) => v.toJson()).toList();
    // }
    data['tagline'] = tagline;
    return data;
  }
}

class Legal {
  String? label;
  String? url;

  Legal({this.label, this.url});

  Legal.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['url'] = url;
    return data;
  }
}

class QuickLinks {
  String? label;
  String? path;

  QuickLinks({this.label, this.path});

  QuickLinks.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['path'] = path;
    return data;
  }
}

class Leadership {
  String? heading;
  String? label;
  List<People>? people;

  Leadership({this.heading, this.label, this.people});

  Leadership.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    label = json['label'];
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(People.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    data['label'] = label;
    if (people != null) {
      data['people'] = people!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class People {
  String? bio;
  String? image;
  String? name;
  String? role;
  String? story;

  People({this.bio, this.image, this.name, this.role, this.story});

  People.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    image = json['image'];
    name = json['name'];
    role = json['role'];
    story = json['story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bio'] = bio;
    data['image'] = image;
    data['name'] = name;
    data['role'] = role;
    data['story'] = story;
    return data;
  }
}

class Navigation {
  QuickLinks? cta;
  List<Links>? links;

  Navigation({this.cta, this.links});

  Navigation.fromJson(Map<String, dynamic> json) {
    cta = json['cta'] != null ? QuickLinks.fromJson(json['cta']) : null;
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cta != null) {
      data['cta'] = cta!.toJson();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? id;
  String? label;
  String? path;

  Links({this.id, this.label, this.path});

  Links.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['path'] = path;
    return data;
  }
}

class SocialLinks {

  String? uri;
  String? label;

  SocialLinks({this.label, this.uri});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    uri = json['url'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = uri;
    data['label'] = label;
    return data;
  }
}
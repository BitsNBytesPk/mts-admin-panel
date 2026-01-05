class ContactData {
  String? sId;
  Content? content;
  String? createdAt;
  String? slug;
  String? status;
  String? title;
  String? updatedAt;
  int? version;

  ContactData(
      {this.sId,
        this.content,
        this.createdAt,
        this.slug,
        this.status,
        this.title,
        this.updatedAt,
        this.version});

  ContactData.fromJson(Map<String, dynamic> json) {
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
  Closing? closing;
  Form? form;
  Hero? hero;
  OfficeLocation? map;
  Sidebar? sidebar;

  Content({this.closing, this.form, this.hero, this.map, this.sidebar});

  Content.fromJson(Map<String, dynamic> json) {
    closing =
    json['closing'] != null ? Closing.fromJson(json['closing']) : null;
    form = json['form'] != null ? Form.fromJson(json['form']) : null;
    hero = json['hero'] != null ? Hero.fromJson(json['hero']) : null;
    map = json['map'] != null ? OfficeLocation.fromJson(json['map']) : null;
    sidebar =
    json['sidebar'] != null ? Sidebar.fromJson(json['sidebar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (closing != null) {
      data['closing'] = closing!.toJson();
    }
    if (form != null) {
      data['form'] = form!.toJson();
    }
    if (hero != null) {
      data['hero'] = hero!.toJson();
    }
    if (map != null) {
      data['map'] = map!.toJson();
    }
    if (sidebar != null) {
      data['sidebar'] = sidebar!.toJson();
    }
    return data;
  }
}

class Closing {
  String? description;
  String? title;

  Closing({this.description, this.title});

  Closing.fromJson(Map<String, dynamic> json) {
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

class Form {
  List<Subjects>? subjects;
  String? title;

  Form({this.subjects, this.title});

  Form.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Subjects {
  String? label;
  String? value;

  Subjects({this.label, this.value});

  Subjects.fromJson(Map<String, dynamic> json) {
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

class OfficeLocation {
  List<LocationCard>? cards;
  String? heading;
  String? label;

  OfficeLocation({this.cards, this.heading, this.label});

  OfficeLocation.fromJson(Map<String, dynamic> json) {
    if (json['cards'] != null) {
      cards = <LocationCard>[];
      json['cards'].forEach((v) {
        cards!.add(LocationCard.fromJson(v));
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

class LocationCard {
  String? accent;
  String? icon;
  String? subtitle;
  String? title;

  LocationCard({this.accent, this.icon, this.subtitle, this.title});

  LocationCard.fromJson(Map<String, dynamic> json) {
    accent = json['accent'];
    icon = json['icon'];
    subtitle = json['subtitle'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accent'] = accent;
    data['icon'] = icon;
    data['subtitle'] = subtitle;
    data['title'] = title;
    return data;
  }
}

class Sidebar {
  Cards? cards;
  String? description;
  String? socialLabel;
  String? title;

  Sidebar({this.cards, this.description, this.socialLabel, this.title});

  Sidebar.fromJson(Map<String, dynamic> json) {
    cards = json['cards'] != null ? Cards.fromJson(json['cards']) : null;
    description = json['description'];
    socialLabel = json['socialLabel'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cards != null) {
      data['cards'] = cards!.toJson();
    }
    data['description'] = description;
    data['socialLabel'] = socialLabel;
    data['title'] = title;
    return data;
  }
}

class Cards {
  List<Mail>? mail;
  List<Office>? office;
  List<Phone>? phone;
  List<Whatsapp>? whatsapp;

  Cards({this.mail, this.office, this.phone, this.whatsapp});

  Cards.fromJson(Map<String, dynamic> json) {
    if (json['mail'] != null) {
      mail = <Mail>[];
      json['mail'].forEach((v) {
        mail!.add(Mail.fromJson(v));
      });
    }
    if (json['office'] != null) {
      office = <Office>[];
      json['office'].forEach((v) {
        office!.add(Office.fromJson(v));
      });
    }
    if (json['phone'] != null) {
      phone = <Phone>[];
      json['phone'].forEach((v) {
        phone!.add(Phone.fromJson(v));
      });
    }
    if (json['whatsapp'] != null) {
      whatsapp = <Whatsapp>[];
      json['whatsapp'].forEach((v) {
        whatsapp!.add(Whatsapp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mail != null) {
      data['mail'] = mail!.map((v) => v.toJson()).toList();
    }
    if (office != null) {
      data['office'] = office!.map((v) => v.toJson()).toList();
    }
    if (phone != null) {
      data['phone'] = phone!.map((v) => v.toJson()).toList();
    }
    if (whatsapp != null) {
      data['whatsapp'] = whatsapp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mail {
  String? href;
  String? primary;

  Mail({this.href, this.primary});

  Mail.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['primary'] = primary;
    return data;
  }
}

class Office {
  List<String>? lines;
  String? title;

  Office({this.lines, this.title});

  Office.fromJson(Map<String, dynamic> json) {
    lines = json['lines'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lines'] = lines;
    data['title'] = title;
    return data;
  }
}

class Phone {
  String? label;
  String? number;

  Phone({this.label, this.number});

  Phone.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['number'] = number;
    return data;
  }
}

class Whatsapp {

  String? primary;
  String? href;

  Whatsapp({
    this.href,
    this.primary
  });

  Whatsapp.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['primary'] = primary;
    return data;
  }
}
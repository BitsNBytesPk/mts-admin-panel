class Package {

  String? id;
  String? name;
  String? mainDesc;
  String? secondaryDesc;
  String? image;
  int? downloads;
  int? pubPoints;
  int? likes;
  bool? status;
  String? packageManagerLink;
  String? githubLink;
  String? version;
  List<String>? keyFeatures;
  List<String>? techStack;

  Package({
    this.id,
    this.name,
    this.downloads,
    this.pubPoints,
    this.status,
    this.image,
    this.mainDesc,
    this.secondaryDesc,
    this.packageManagerLink,
    this.version,
    this.likes,
    this.githubLink,
    this.keyFeatures,
    this.techStack,
  });

  Package.fromJson(Map<String, dynamic> json) {
    id = json['_id'].toString();
    name = json['name'];
    downloads = json['downloads'];
    pubPoints = json['pub_points'];
    status = json['status'];
    image = json['image'];
    mainDesc = json['main_desc'];
    secondaryDesc = json['secondary_desc'];
    packageManagerLink = json['package_manager_link'];
    version = json['version'];
    likes = json['likes'];
    keyFeatures = json['key_features'].cast<String>();
    techStack = json['tech_stack'].cast<String>();
    githubLink = json['github_link'];

  }
}
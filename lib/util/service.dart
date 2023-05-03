class Services {
  final int? id;
  final String? slug;
  final String? route;
  final String? icon;
  final String name;
  final String? desc;

  Services({
    this.id,
    this.slug,
    this.route,
    this.icon,
    required this.name,
    this.desc,
  });

  Services.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        slug = json['slug'] as String?,
        route = json['route'] as String?,
        icon = json['icon'] as String?,
        name = json['name_lang'] as String,
        desc = json['desc_lang'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'slug' : slug,
    'route' : route,
    'icon' : icon,
    'name_lang' : name,
    'desc_lang' : desc
  };
}
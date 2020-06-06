class MainEntity {
  final String title;
  final String id;
  final String image_url;

  MainEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image_url = json['image_url'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': image_url
      };

  MainEntity(this.title, this.id, this.image_url);
}

import 'package:flutter/cupertino.dart';

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

  MainEntity({@required this.title, @required this.id, @required this.image_url});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          id == other.id &&
          image_url == other.image_url;

  @override
  int get hashCode => title.hashCode ^ id.hashCode ^ image_url.hashCode;
}

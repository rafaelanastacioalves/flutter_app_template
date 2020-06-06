import 'package:flutter/cupertino.dart';

class EntityDetails {
  final String title;
  final String id;
  final String price;
  final String price_currency;
  final String image_url;

  EntityDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        price_currency = json['price_currency'],
        image_url = json['image_url'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'price_currency': price_currency,
    'image_url': image_url
  };

  EntityDetails(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.price_currency,
      @required this.image_url});
}

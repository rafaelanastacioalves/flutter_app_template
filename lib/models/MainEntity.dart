class MainEntity {
  final String title;
  final String id ;
  MainEntity({this.title = "default title", this.id});

  MainEntity.fromJson(Map<String, dynamic> json) :
    id =  json['id'],
    title = json['title'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title
  };
}

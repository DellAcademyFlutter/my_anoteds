class PostitModel {
  int id;
  String title;
  String desc;
  String tag;

  PostitModel({this.id, this.title, this.desc, this.tag});

  PostitModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    tag = json['tag'];
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['tag'] = tag;
    return data;
  }
}
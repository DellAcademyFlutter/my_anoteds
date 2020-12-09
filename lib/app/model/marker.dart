class Marker {
  Marker({this.id, this.title, this.userId});

  int id;
  int userId;
  String title;


  /// Atribui os valores dos parametros deste [Marker] dado um [Map] Jason.
  Marker.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    title = map['title'];
    userId = map['userId'];
  }

  /// Este metodo codifica este [Marker] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['userId'] = this.userId;
    return data;
  }
}

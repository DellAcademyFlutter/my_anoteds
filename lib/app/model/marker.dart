class Marker {
  Marker({this.id, this.title, this.userId, this.isSelected});

  int id;
  int userId;
  String title;
  bool isSelected;


  /// Atribui os valores dos parametros deste [Marker] dado um [Map] Jason.
  Marker.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    title = map['title'];
    userId = map['userId'];
    isSelected = map['isSelected'] == "true";
  }

  /// Este metodo codifica este [Marker] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['userId'] = userId;
    data['isSelected'] = isSelected;
    return data;
  }
}

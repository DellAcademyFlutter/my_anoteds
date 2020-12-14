class Marking {
  Marking({this.userId, this.postitId, this.markerId});

  int userId;
  int postitId;
  int markerId;

  /// Atribui os valores dos parametros deste [Marker] dado um [Map] Jason.
  Marking.fromMap({Map<String, dynamic> map}) {
    userId = map['userId'];
    postitId = map['postitId'];
    markerId = map['markerId'];
  }

  /// Este metodo codifica este [Marker] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['postitId'] = postitId;
    data['markerId'] = markerId;
    return data;
  }
}

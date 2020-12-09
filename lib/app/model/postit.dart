class Postit {
  // Construtor da classe
  Postit(
      {this.id,
      this.title,
      this.description,
      this.color,
      this.userId,
      this.isPinned});

  // Atributos
  int id;
  String title;
  String description;
  String color;
  int userId;
  bool isPinned;

  /// Atribui os valores dos parametros deste [Postit] dado um [Map] Jason.
  Postit.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    color = map['color'];
    userId = map['userId'];
    isPinned = map['isPinned'] == "true";
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['color'] = color;
    data['userId'] = userId;
    data['isPinned'] = isPinned.toString();
    return data;
  }
}

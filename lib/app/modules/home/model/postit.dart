class Postit {
  // Construtor da classe
  Postit(
      {this.id,
        this.title,
        this.description,
        this.color,
        this.user_id,
        this.is_pinned});

  // Atributos
  int id;
  String title;
  String description;
  String color;
  int user_id;
  bool is_pinned;

  /// Atribui os valores dos parametros deste [Postit] dado um [Map] Jason.
  Postit.fromMap({Map<String, dynamic> map}) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    color = map['color'];
    user_id = map['user_id'];
    is_pinned = map['is_pinned'] == "true";
  }

  /// Este metodo codifica este [Postit] em um [Map] Json.
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['color'] = this.color;
    data['user_id'] = this.user_id;
    data['is_pinned'] = this.is_pinned.toString();
    return data;
  }
}

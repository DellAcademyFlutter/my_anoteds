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
  Postit.fromMap({Map<String, dynamic> json}) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    color = json['color'];
    user_id = json['user_id'];
    is_pinned = json['is_pinned'] == "true";
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

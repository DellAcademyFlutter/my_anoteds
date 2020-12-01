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
}

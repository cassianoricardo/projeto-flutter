class Usuario {
  int id;
  String name;
  String endereco;
  Usuario({this.id, this.name, this.endereco});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"],
      name: json["name"],
      endereco: json["endereco"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'endereco': endereco};
  }
}

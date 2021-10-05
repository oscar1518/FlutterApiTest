class Artist {
  int id;
  String name;
  int age;
  String? genre;

  Artist(
      {this.id = 0,
      required this.name,
      required this.age,
      required this.genre});

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      genre: json['genre']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'age': age, 'genre': genre};
}

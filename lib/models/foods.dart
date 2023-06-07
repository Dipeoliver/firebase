class Foods {
  final String name;
  final String images;

  Foods(this.name, this.images);

  factory Foods.fromJson(dynamic json) {
    return Foods(json['title'] as String, json['image'] as String);
  }

  static List<Foods> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Foods.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Foods {name: $name, image: $images}';
  }
}

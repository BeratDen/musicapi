class Category {
  final int id;
  final String name;
  final String description;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Category(
      {required this.id,
      required this.name,
      required this.description,
      required this.slug,
      required this.createdAt,
      required this.updatedAt});

  /// The function `fromJson` is a factory constructor in Dart that takes a JSON object and returns a `Category` object if
  /// the JSON is in the expected format, otherwise it throws a `FormatException`.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): A map containing the JSON data for a category.
  ///
  /// Returns:
  ///   The factory method is returning an instance of the Category class.
  factory Category.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String description,
        'slug': String slug,
        'createdAt': String
            createdAt, // we get date as string from json variable
        'updatedAt': String
            updatedAt // we get date as string from json variable
      } =>
        Category(
          id: id,
          name: name,
          description: description,
          slug: slug,
          createdAt: DateTime.parse(
              createdAt), // after we get date as string from json variable formatting to fit class variable
          updatedAt: DateTime.parse(
              updatedAt), // after we get date as string from json variable formatting to fit class variable
        ),
      _ => throw const FormatException('Failed to fetch category')
    };
  }

  @override
  String toString() {
    return '$id, $name, $description, $slug, $createdAt, $updatedAt';
  }
}

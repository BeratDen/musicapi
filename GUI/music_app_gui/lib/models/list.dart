class MusicList {
  final int id;
  final String name;
  final String description;
  final String slug;
  final String image;
  final String creator;
  final List musics;

  const MusicList(
      {required this.id,
      required this.name,
      required this.description,
      required this.slug,
      required this.image,
      required this.creator,
      required this.musics});

  factory MusicList.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String description,
        'slug': String slug,
        'image': String image,
        'creator': String creator,
        'musics': List musics
      } =>
        MusicList(
          id: id,
          name: name,
          description: description,
          slug: slug,
          image: image,
          creator: creator,
          musics: musics,
        ),
      _ => throw const FormatException('Failed to fetch list')
    };
  }
}

// song.dart
class Song {
  final String id;
  final String name;
  final String artist;
  final String album;
  final String url;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.album,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      artist: json['primaryArtists'],
      album: json['album']['name'],
      url: json['downloadUrl'][0]['link'], // Choose the desired quality
    );
  }
}

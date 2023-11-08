// // api_service.dart
// import 'dart:convert';
// import 'package:beatz_player/models/online_song.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static Future<List<Song>> fetchSongs(String query) async {
//     final response = await http.get(
//       Uri.parse('https://saavn.me/search/songs?query=$query&page=1&limit=2'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final songsData = data['data']['results'];

//       List<Song> songs = [];
//       for (var songData in songsData) {
//         final song = Song.fromJson(songData);
//         songs.add(song);
//       }

//       return songs;
//     } else {
//       throw Exception('Failed to load songs');
//     }
//   }
// }

// // song_list.dart
// import 'package:audioplayers/audioplayers.dart';
// import 'package:beatz_player/models/online_song.dart';
// import 'package:flutter/material.dart';


// class SongList extends StatelessWidget {
//   final List<Song> songs;

//   SongList({required this.songs});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: songs.length,
//       itemBuilder: (context, index) {
//         final song = songs[index];
//         return ListTile(
//           title: Text(song.name),
//           subtitle: Text('${song.artist} - ${song.album}'),
//           onTap: () async{
//             // Implement song playback here
//             final player = AudioPlayer();
// await player.play(UrlSource(song.url));

//             //AudioPlayerService.playSong(song.url); // Pass the song URL
//           },
//         );
//       },
//     );
//   }
// }

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:beatz_player/models/song.dart';
import 'package:beatz_player/presentation/widgets/bottom_music_bar.dart';
import 'package:beatz_player/presentation/widgets/song_list.dart';
import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<Song> songs = [];
  AudioPlayer audioPlayer = AudioPlayer();
  int selectedSongIndex = -1; // Keep track of the selected song index
  @override
  void initState() {
    super.initState();
    fetchAudioFiles();
  }

  Future<void> fetchAudioFiles() async {
  
  PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    List<String> audioExtensions = [
      '.mp3',
      '.m4a',
      '.flac'
    ];
    List<FileSystemEntity> audioFiles = [];
    Directory directory = Directory('/storage/emulated/0/Music'); // Update this path to the desired directory

    if (directory.existsSync()) {
      await _findAudioFiles(directory, audioExtensions, audioFiles);
    } else {
      print("Directory does not exist: ${directory.path}");
    }

    for (var file in audioFiles) {
      
      // Extract song information from the file and create a Song object
      songs.add(Song(
        title: basenameWithoutExtension(file.path),
        artist: 'Unknown Artist', // You can fetch artist information if available
        filePath: file.path,
      ));
    }
    setState(() {});
  } else {
    print("Permission denied");
  }
}


  Future<void> _findAudioFiles(Directory directory, List<String> extensions,
      List<FileSystemEntity> audioFiles) async {
    final List<FileSystemEntity> files = directory.listSync();

    for (var file in files) {
      if (file is File &&
          extensions.contains(extension(file.path).toLowerCase())) {
        audioFiles.add(file);
      } else if (file is Directory) {
        await _findAudioFiles(file, extensions, audioFiles);
      }
    }
  }
Future<void> playSong(int index) async {
    // Check if the selected song index is different from the currently playing song
    if (selectedSongIndex != index) {
      // Stop the currently playing song (if any)
      await audioPlayer.stop();

      // Play the new selected song
      await audioPlayer.play(UrlSource(songs[index].filePath)); // Assuming songs contain file paths

      // Update the selected song index
      setState(() {
        selectedSongIndex = index;
      });
    } else {
      // If the same song is tapped again, pause or resume it
      // if (audioPlayer.state == PlayerState.PLAYING) {
      //   await audioPlayer.pause();
      // } else if (audioPlayer.state == PlayerState.PAUSED) {
      //   await audioPlayer.resume();
      // }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      appBar: AppBar(
        title: Text('Beatz'),
      ),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SongList(songs: songs, playSong: playSong),
          bottomNavigationBar: BottomMusicBar(currentSongTitle: songs[selectedSongIndex].title,currentSongArtist: songs[selectedSongIndex].artist),
    );
  }
  

}

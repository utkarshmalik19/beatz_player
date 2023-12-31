import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:beatz_player/models/song.dart';
import 'package:beatz_player/presentation/screens/current_song_screen.dart';
import 'package:beatz_player/presentation/widgets/bottom_music_bar.dart';
import 'package:beatz_player/presentation/widgets/song_list.dart';
import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song> songs = [];
  AudioPlayer audioPlayer = AudioPlayer();
   bool? isPlaying;
  int selectedSongIndex = -1; // Keep track of the selected song index
  @override
  void initState() {
    super.initState();
    fetchAudioFiles();
  }

  Future<void> fetchAudioFiles() async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      List<String> audioExtensions = ['.mp3', '.m4a', '.flac'];
      List<FileSystemEntity> audioFiles = [];
      List<Directory> searchDirectories = [];
      searchDirectories.add(Directory('/storage/emulated/0/'));

      for (var directory in searchDirectories) {
        try {
          if (directory.existsSync() &&
              !directory.path.contains("/Android/data/")) {
            await _findAudioFiles(directory, audioExtensions, audioFiles);
          }
        } catch (e) {
          print("Error accessing directory: ${directory.path}");
        }
      }

      for (var file in audioFiles) {
        // Extract song information from the file and create a Song object
        songs.add(Song(
          title: basenameWithoutExtension(file.path),
          artist:
              'Unknown Artist', // You can fetch artist information if available
          filePath: file.path,
        ));
      }
      audioPlayer.onPlayerComplete.listen((event) {
      // Called when the current song completes
      playNextSong();
    });
      setState(() {});
    } else {
      print("Permission denied");
    }
  }
void playNextSong() {
    // Increment the selected song index to play the next song
    int nextIndex = selectedSongIndex + 1;

    // Check if there are more songs to play
    if (nextIndex < songs.length) {
      // Stop the currently playing song (if any)
      audioPlayer.stop();

      // Play the next song
      playSong(nextIndex);
    } else {
      // No more songs in the list, you can handle this as needed
      // For example, you can stop the player or loop back to the first song
      // audioPlayer.stop();
      // selectedSongIndex = -1; // Set to -1 to indicate no selected song
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
      await audioPlayer.play(UrlSource(
          songs[index].filePath)); // Assuming songs contain file paths

      // Update the selected song index
      setState(() {
        selectedSongIndex = index;
      });
    } else {
      //If the same song is tapped again, pause or resume it
      if (audioPlayer.state == PlayerState.playing) {
        await audioPlayer.pause();
      } else if (audioPlayer.state == PlayerState.paused) {
        await audioPlayer.resume();
      }
    }
  }

  void isPlayingValue() {
    if (audioPlayer.state == PlayerState.playing) {
      setState(() {
        isPlaying = true;
      });
    } else if (audioPlayer.state == PlayerState.paused) {
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: AppConstants.bgColor,
        elevation: 0,
        title: Text(
          'Beatz Music Player',
          style: AppConstants.headerTextStyle,
        ),
      ),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SongList(songs: songs, playSong: playSong),
      bottomNavigationBar: selectedSongIndex == -1
          ? null
          : GestureDetector(
              onTap: () {
                isPlayingValue();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentSongScreen(
                            audioPlayer: audioPlayer,
                            isPlaying: isPlaying!,
                          )),
                );
              },
              child: BottomMusicBar(
                currentSongTitle: songs[selectedSongIndex].title,
                currentSongArtist: songs[selectedSongIndex].artist,
                audioPlayer: audioPlayer,
              ),
            ),
    );
  }
}

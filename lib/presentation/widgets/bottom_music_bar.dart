import 'package:audioplayers/audioplayers.dart';
import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';

class BottomMusicBar extends StatefulWidget {
  final String currentSongTitle;
  final String currentSongArtist;
  final AudioPlayer audioPlayer;
  
  const BottomMusicBar(
      {super.key,
      required this.currentSongTitle,
      required this.currentSongArtist,
      required this.audioPlayer});

  @override
  State<BottomMusicBar> createState() => _BottomMusicBarState();
}

class _BottomMusicBarState extends State<BottomMusicBar> {
    final ValueNotifier<PlayerState> _playerStateNotifier = ValueNotifier(PlayerState.playing);
  @override
  void initState() {
    super.initState();
     // Listen to changes in the player state
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      
      setState(() {
        _playerStateNotifier.value = state;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.music_note,
                  color: Colors.white), // Add a music note icon
              SizedBox(
                width: 20,
              ),
              Text(
                widget.currentSongTitle,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  _playerStateNotifier.value == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
                ),
                    onPressed: () {
                      if (_playerStateNotifier.value == PlayerState.playing) {
                    widget.audioPlayer.pause();
                  } else {
                    widget.audioPlayer.resume();
                  }
                    },
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

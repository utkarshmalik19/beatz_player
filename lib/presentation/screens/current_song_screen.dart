import 'package:audioplayers/audioplayers.dart';
import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';

class CurrentSongScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final bool isPlaying;

  const CurrentSongScreen(
      {super.key, required this.audioPlayer, required this.isPlaying});
  @override
  State<CurrentSongScreen> createState() => _CurrentSongScreenState();
}

class _CurrentSongScreenState extends State<CurrentSongScreen> {
  late bool isPlaying;
  late double sliderValue;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    // Listen to changes in the player state
    sliderValue = 0.0;
    isPlaying = widget.isPlaying;
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    widget.audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        sliderValue = duration.inMilliseconds.toDouble();
      });
    });
    _initializeDuration();
  }

  Future<void> _initializeDuration() async {
    final d = await widget.audioPlayer.getDuration();
    setState(() {
      duration = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      appBar: AppBar(
        title: Text('Now Playing'),
        // Customize the app bar as needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image placeholder (replace with album art)
            SizedBox(
                height: 300, child: Image.asset('assets/images/music.png')),

            // Progress bar, play/pause button, next song, previous song buttons
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Slider(
                  value: sliderValue.clamp(0.0, (duration?.inMilliseconds.toDouble() ?? 1.0)),
                  min: 0.0,
                  max: (duration?.inMilliseconds.toDouble() ?? 0.0),
                  onChanged: (double value) {
                    setState(() {
                      sliderValue = value;
                    });
                    widget.audioPlayer
                        .seek(Duration(milliseconds: value.toInt()));
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: () {
                    // Implement logic for skipping to the previous song
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: IconButton(
                    icon: Icon(
                      isPlaying == true ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isPlaying == true) {
                          widget.audioPlayer.pause();
                        } else {
                          widget.audioPlayer.resume();
                        }
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next, color: Colors.white),
                  onPressed: () {
                    // Implement logic for skipping to the next song
                    // Get the duration of the current song
                    widget.audioPlayer.getDuration().then((duration) {
                      // Seek to the end of the current song
                      widget.audioPlayer.seek(
                          Duration(milliseconds: duration!.inMilliseconds - 1));
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

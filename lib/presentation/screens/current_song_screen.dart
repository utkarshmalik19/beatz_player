import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';

class CurrentSongScreen extends StatelessWidget {
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
              child: SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: 0.5,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

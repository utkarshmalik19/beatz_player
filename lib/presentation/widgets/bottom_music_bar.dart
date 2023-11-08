import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';

class BottomMusicBar extends StatelessWidget {
  final String currentSongTitle;
  final String currentSongArtist;
  const BottomMusicBar(
      {super.key,
      required this.currentSongTitle,
      required this.currentSongArtist});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        decoration: BoxDecoration(
            color: AppConstants.bgColor,
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
                  SizedBox(width: 20,),
              Text(
                currentSongTitle,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.play_arrow,color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}

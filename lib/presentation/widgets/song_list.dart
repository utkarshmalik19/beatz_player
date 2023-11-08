
import 'package:beatz_player/models/song.dart';
import 'package:beatz_player/utils/consts.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  final List<Song> songs;
  final void Function(int index) playSong;
  const SongList({super.key, required this.songs, required this.playSong});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
              itemCount: widget.songs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListTile(
                      trailing: Icon(Icons.more_vert, color: Colors.white,),
                      onTap: () => widget.playSong(index),
                      title: Text(widget.songs[index].title, style: AppConstants.bigTextStyle,),
                    ),
                  ),
                );
              },
            );
  }
}
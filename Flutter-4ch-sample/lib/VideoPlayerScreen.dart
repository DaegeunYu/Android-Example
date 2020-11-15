import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget{
  VideoPlayerScreen({Key key, this.url, this.aspectRatio, this.mainScreen}) : super(key: key);

  String url;
  double aspectRatio;
  bool mainScreen;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    if (widget.mainScreen) {
      _controller.setVolume(100);
    } else {
      _controller.setVolume(0);
    }
    _controller.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.mainScreen) {
              _controller.setVolume(100);
            } else {
              _controller.setVolume(0);
            }
            return AspectRatio(
              aspectRatio: widget.aspectRatio,//_controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause:Icons.play_arrow),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:group_9_app/datastructures/video_player_widget.dart';

class StoryPage extends StatefulWidget{
  const StoryPage({super.key, required this.file, required this.type});
  final String file;
  final String type;

  @override
  State<StatefulWidget> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>{

  VideoPlayerController? _controller;
  
  @override
  void initState() {
    super.initState();
    if (widget.type != 'IMG') { 
      _controller = VideoPlayerController.asset(widget.file)
    ..addListener(() => setState(() {}))
    ..initialize()
    .then((value) => _controller!.play()); 
    }
  }

  @override
  void dispose(){
    if (_controller != null) { _controller!.dispose(); }
    super.dispose();
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget _loadCorrectFileType() {
    if (widget.type != 'IMG'){
      return VideoPlayerWidget(file: widget.file, controller: _controller);
    }
    else {
      return Image.asset(widget.file, fit: BoxFit.fill,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Positioned(
          child: SizedBox(
            width: double.infinity,
            height: 500,
            child: _loadCorrectFileType(),
          ),
        ),
        Positioned(
          left: 10.0,
          top: 10.0,
          child: IconButton(
            onPressed: () => _navigateBack(),
            icon: const Icon(Icons.close),
          ),
        ),
      ]);
  }
  
}
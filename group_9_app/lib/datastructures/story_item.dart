import 'package:group_9_app/pages/storyPage.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget{
  const StoryItem({super.key, required this.type, required this.headerImg, required this.file});
  final String type;
  final String headerImg;
  final String file;

  Widget _loadCorrectStoryItem() {
    if (type == "IMG") {
      return Image.asset(headerImg);
    }
    else {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(child: Image.asset(headerImg)),
          const Positioned(child: Icon(Icons.play_arrow, size: 30.0, color: Colors.white,)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StoryPage(file: file, type: type)
        ));
      },
      child: SizedBox(
        width: 300,
        height: 300,
        child: _loadCorrectStoryItem(),
      ),
    );
  }
}
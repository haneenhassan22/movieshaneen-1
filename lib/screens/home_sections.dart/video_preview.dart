import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutter/material.dart';

class VideoPreview extends StatelessWidget {
  VideoPreview({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "${Constants.imagePath}${snapshot.data[0].posterPath}",
          // Replace with actual image URL
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 150,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 60,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data[0].originalTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${snapshot.data[0].releaseDate}',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

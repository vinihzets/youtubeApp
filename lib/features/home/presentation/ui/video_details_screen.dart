import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatelessWidget {
  final dynamic video;
  const VideoDetailsScreen({required this.video, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network(video.imageHigh),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(video.title),
              ),
              const SizedBox(
                height: 80,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.reset_tv_rounded,
                    size: 50,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

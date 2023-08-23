import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPickerScreen extends StatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  String? selectedVideoPath;
  Future<void> pickAndTrimVideo(BuildContext context) async {
    final XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    VideoPlayerController videoController = VideoPlayerController.file(File(video.path));

    await videoController.initialize();

    double videoDuration = videoController.value.duration.inSeconds.toDouble();
    int startDuration = 0;
    int endDuration = videoDuration.toInt();
    if (videoDuration > 15) {
      startDuration = (videoDuration - 15).toInt();
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Trim Video"),
        content: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(videoController),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              videoController.dispose();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              videoController.pause();
              String outputPath = video.path.replaceAll('.mp4', '_trimmed.mp4');
              await trimVideo(video.path, outputPath, startDuration, endDuration);
              setState(() {
                selectedVideoPath = outputPath;
              });
            },
            child: Text("Trim"),
          ),
        ],
      ),
    );
  }

   trimVideo(String inputPath, String outputPath, int startDuration, int endDuration) async {
    final File inputFile = File(inputPath);
    final File outputFile = File(outputPath);

    await outputFile.writeAsBytes(await inputFile.readAsBytes());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Picker & Trimmer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (selectedVideoPath != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: VideoPlayer(VideoPlayerController.file(File(selectedVideoPath!))),
              ),
            ElevatedButton(
              onPressed: () => pickAndTrimVideo(context),
              child: Text('Pick and Trim Video'),
            ),
          ],
        ),
      ),
    );
  }
}
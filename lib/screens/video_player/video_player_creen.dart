import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/utils/get_video_duration.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.url});

  final String url;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url))
          ..addListener(() {
            setState(() {});
          })
          ..setLooping(false)
          ..initialize().then((value) => videoPlayerController.play());
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: videoPlayerController.value.isInitialized
          ? _VideoPlayerWidget(videoPlayerController: videoPlayerController)
          : const CircularLoader(color: Colors.white, size: 100),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  const _VideoPlayerWidget({
    required this.videoPlayerController,
  });

  final VideoPlayerController videoPlayerController;

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onDoubleTap: () {
            if (isPlaying) {
              setState(() {
                isPlaying = false;
              });
              widget.videoPlayerController.pause();
            } else {
              setState(() {
                isPlaying = true;
              });
              widget.videoPlayerController.play();
            }
          },
          child: Center(
            child: AspectRatio(
                aspectRatio: widget.videoPlayerController.value.aspectRatio,
                child: VideoPlayer(widget.videoPlayerController)),
          ),
        ),
        Container(
          height: 50,
          width: double.maxFinite,
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                isPlaying
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isPlaying = false;
                            widget.videoPlayerController.pause();
                          });
                        },
                        icon: const Icon(FeatherIcons.pause),
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () {
                          isPlaying = true;
                          widget.videoPlayerController.play();
                        },
                        icon: const Icon(FeatherIcons.play),
                        color: Colors.white,
                      ),
                const SizedBox(
                  width: 10,
                ),
                ValueListenableBuilder(
                  valueListenable: widget.videoPlayerController,
                  builder: (context, value, child) {
                    return Text(
                      getVideoDuration(value.position),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: VideoProgressIndicator(
                    widget.videoPlayerController,
                    allowScrubbing: true,
                    colors:
                        const VideoProgressColors(playedColor: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  getVideoDuration(widget.videoPlayerController.value.duration),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

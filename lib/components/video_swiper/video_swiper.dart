import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/content_card/content_card.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/data/remote/ofma/content_request.dart';
import 'package:ofma_app/models/content_response.dart';
import 'package:ofma_app/theme/app_colors.dart';

class VideoSwiper extends StatefulWidget {
  const VideoSwiper({
    super.key,
    required this.category,
    required this.color,
  });

  final String category;
  final Color color;

  @override
  State<VideoSwiper> createState() => _VideoSwiperState();
}

class _VideoSwiperState extends State<VideoSwiper> {
  late Future<ContentResponse?> contentFutureRequest;

  @override
  void initState() {
    final contentRequest = ContentRequest();
    contentFutureRequest =
        contentRequest.getContent(category: widget.category, highlighted: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 220,
        child: FutureBuilder(
          future: contentFutureRequest,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentCard(
                    category: widget.category,
                    color: widget.color,
                    content: snapshot.data?.result?[index],
                  );
                },
                itemCount: snapshot.data?.result?.length ?? 0,
                viewportFraction: 0.75,
                scale: 0.9,
              );
            } else {
              return CircularLoader(color: AppColors.primaryColor, size: 50);
            }
          },
        ),
      ),
    );
  }
}

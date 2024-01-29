import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/video_swiper/video_swiper.dart';
import 'package:ofma_app/delegate/concert_search_delegate.dart';
import 'package:ofma_app/delegate/interview_search_delegate.dart';
import 'package:ofma_app/enums/cotent_category.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/to_plural.dart';
import 'package:ofma_app/utils/to_title_case.dart';

class ExclusiveContentScreen extends StatelessWidget {
  const ExclusiveContentScreen({super.key, required this.category});

  final ContentCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(toTitleCase(toPlural(category.value))),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: category.value == ContentCategory.concert.value
                      ? ConcertSearchDelegate()
                      : InterviewsSearchDelegate());
            },
            icon: const Icon(FeatherIcons.search),
            color: AppColors.secondaryColor,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 280,
              child: _ExclusiveContentHeader(category: category),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              category.value == ContentCategory.concert.value
                  ? 'Ve las grabaciones de los conciertos'
                  : 'Entrevistas en exclusiva para ti',
              style: const TextStyle(fontSize: 18),
            ),
            const Text(
              'desde nuestra aplicación',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              width: 300,
              child: Divider(
                thickness: 0.5,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 7),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3))),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.format_indent_increase,
                              size: 16,
                              color: Colors.black45,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(toTitleCase(toPlural(category.value))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${toTitleCase(toPlural(category.value))} destacados',
                        style: const TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                VideoSwiper(
                    category: category.value,
                    color: category.value == ContentCategory.concert.value
                        ? Colors.pinkAccent
                        : Colors.orange),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExclusiveContentHeader extends StatelessWidget {
  const _ExclusiveContentHeader({required this.category});

  final ContentCategory category;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          category.value == ContentCategory.concert.value
              ? 'assets/backgrounds/concert_content_search_banner.webp'
              : 'assets/backgrounds/interview_content_search_banner.webp',
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: category.value == ContentCategory.concert.value
                  ? Colors.pinkAccent.withAlpha(200)
                  : Colors.orange.withAlpha(200)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(3))),
                  child: Text(
                    toTitleCase(toPlural(category.value)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    category.value == ContentCategory.concert.value
                        ? '¡Repite los mejores conciertos de la OFMA!'
                        : '¡Mira entrevistas exclusivas para ti!',
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white, overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

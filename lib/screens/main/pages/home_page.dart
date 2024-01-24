import 'package:card_swiper/card_swiper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/components/musician_card/musician_card.dart';
import 'package:ofma_app/components/video_swiper/video_swiper.dart';
import 'package:ofma_app/data/remote/ofma/concert_request.dart';
import 'package:ofma_app/data/remote/ofma/musician_request.dart';
import 'package:ofma_app/enums/cotent_category.dart';
import 'package:ofma_app/models/concert_response.dart';
import 'package:ofma_app/models/musician.response.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: SvgPicture.asset(
          'assets/logo/ofma_logo.svg',
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _ConcertsSection(),
            SizedBox(
              height: 30,
            ),
            _ContentSection(),
            SizedBox(
              height: 20,
            ),
            _HighlightedConcertVideos(),
            SizedBox(
              height: 20,
            ),
            _HighlightedEnterviewsVideos(),
            SizedBox(
              height: 20,
            ),
            _HighlightedMusicians(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConcertsSection extends StatefulWidget {
  const _ConcertsSection();

  @override
  State<_ConcertsSection> createState() => _ConcertsSectionState();
}

class _ConcertsSectionState extends State<_ConcertsSection> {
  late Future<ConcertResponse?> concertFutureRequest;

  @override
  void initState() {
    final concertRequest = ConcertRequest();
    concertFutureRequest = concertRequest.getConcerts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = SwiperController();
    return Stack(
      children: [
        Image.asset(
          'assets/backgrounds/home_background_image.webp',
          width: double.infinity,
          height: 260,
          fit: BoxFit.cover,
        ),
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 250,
            child: FutureBuilder(
              future: concertFutureRequest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Swiper(
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return TouchableOpacity(
                        onTap: () => context.pushNamed(
                            AppRouterConstants.concertScreen,
                            pathParameters: {
                              'id': snapshot.data?.result?[index].id ?? ''
                            }),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            (snapshot.data?.result?[index].imageUrl ?? '')
                                .replaceAll('localhost', '10.0.2.2'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data?.result?.length ?? 0,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    itemWidth: 380,
                    itemHeight: 180,
                    loop: false,
                    layout: SwiperLayout.TINDER,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white24,
                          activeColor: AppColors.secondaryColor,
                          size: 6.0,
                          activeSize: 9.0),
                    ),
                  );
                } else {
                  return const CircularLoader(color: Colors.white, size: 50);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        _ContentSectionButton(
            onTap: () => context.pushNamed(
                AppRouterConstants.exclusiveContentScreen,
                extra: ContentCategory.concert),
            text: 'Conciertos',
            icon: CommunityMaterialIcons.music_circle_outline,
            color: AppColors.pink),
        const SizedBox(
          width: 30,
        ),
        _ContentSectionButton(
            onTap: () => context.pushNamed(
                AppRouterConstants.exclusiveContentScreen,
                extra: ContentCategory.interview),
            text: 'Entrevistas',
            icon: CommunityMaterialIcons.microphone_outline,
            color: AppColors.yellow),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class _ContentSectionButton extends StatelessWidget {
  const _ContentSectionButton({
    required this.onTap,
    required this.text,
    required this.icon,
    required this.color,
  });

  final Function onTap;
  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );

    final boxDecoration = BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    );

    return Expanded(
      child: TouchableOpacity(
        onTap: () => onTap(),
        child: Container(
          height: 130,
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70,
                color: Colors.white,
              ),
              Text(
                text,
                style: textStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightedConcertVideos extends StatelessWidget {
  const _HighlightedConcertVideos();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '¡Escúchanos desde tu casa!',
                style: textStyle,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        VideoSwiper(
          category: 'concierto',
          color: Colors.pinkAccent,
        )
      ],
    );
  }
}

class _HighlightedEnterviewsVideos extends StatelessWidget {
  const _HighlightedEnterviewsVideos();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '¡Conoce a nuestros músicos!',
                style: textStyle,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        VideoSwiper(
          category: 'entrevista',
          color: Colors.orange,
        )
      ],
    );
  }
}

class _HighlightedMusicians extends StatelessWidget {
  const _HighlightedMusicians();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '¡Músicos destacados!',
                style: textStyle,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        _MusicianSwiper()
      ],
    );
  }
}

class _MusicianSwiper extends StatefulWidget {
  const _MusicianSwiper();

  @override
  State<_MusicianSwiper> createState() => _MusicianSwiperState();
}

class _MusicianSwiperState extends State<_MusicianSwiper> {
  late Future<MusicianResponse?> musiciansFutureRequest;

  @override
  void initState() {
    final musicianRequest = MusicianRequest();
    musiciansFutureRequest = musicianRequest.getMusicians(highlighted: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160,
        child: FutureBuilder(
          future: musiciansFutureRequest,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return MusicianCard(
                    musician: snapshot.data?.result?[index],
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

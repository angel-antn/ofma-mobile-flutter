import 'package:card_swiper/card_swiper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class _ConcertsSection extends StatelessWidget {
  const _ConcertsSection();

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
            child: Swiper(
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    "https://via.placeholder.com/380x180",
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: 2,
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
            onTap: () {},
            text: 'Conciertos',
            icon: CommunityMaterialIcons.music_circle_outline,
            color: AppColors.pink),
        const SizedBox(
          width: 30,
        ),
        _ContentSectionButton(
            onTap: () {},
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
          height: 20,
        ),
        _VideoSwiper()
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
          height: 20,
        ),
        _VideoSwiper()
      ],
    );
  }
}

class _VideoSwiper extends StatelessWidget {
  const _VideoSwiper();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                "https://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: 10,
          viewportFraction: 0.75,
          scale: 0.9,
        ),
      ),
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
          height: 20,
        ),
        _MusicianSwiper()
      ],
    );
  }
}

class _MusicianSwiper extends StatelessWidget {
  const _MusicianSwiper();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 140,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                "https://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: 10,
          viewportFraction: 0.75,
          scale: 0.9,
        ),
      ),
    );
  }
}

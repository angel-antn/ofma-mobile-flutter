import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/loaders/circular_loader.dart';
import 'package:ofma_app/components/musician_card/musician_card.dart';
import 'package:ofma_app/data/remote/ofma/musician_request.dart';
import 'package:ofma_app/delegate/musician_search_delegate.dart';
import 'package:ofma_app/models/musician.response.dart';
import 'package:ofma_app/theme/app_colors.dart';

class MusicianPage extends StatelessWidget {
  const MusicianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Músicos'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MuscianSearchDelegate());
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
            const SizedBox(
              height: 280,
              child: _MusicianPageHeader(),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Conoce a los músicos que te deleitan',
              style: TextStyle(fontSize: 18),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 7),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3))),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.format_indent_increase,
                              size: 16,
                              color: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Músicos'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Músicos destacados',
                        style: TextStyle(color: Colors.black38),
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
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const _HighlightedMusiciansList(),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MusicianPageHeader extends StatelessWidget {
  const _MusicianPageHeader();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          'assets/backgrounds/musician_search_banner.webp',
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration:
              BoxDecoration(color: AppColors.secondaryColor.withAlpha(200)),
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
                  child: const Text(
                    'Músicos',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    '¡Conoce a los músicos de la OFMA!',
                    maxLines: 1,
                    style: TextStyle(
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

class _HighlightedMusiciansList extends StatefulWidget {
  const _HighlightedMusiciansList();

  @override
  State<_HighlightedMusiciansList> createState() =>
      _HighlightedMusiciansListState();
}

class _HighlightedMusiciansListState extends State<_HighlightedMusiciansList> {
  late Future musiciansFutureRequest;

  @override
  void initState() {
    final musicianRequest = MusicianRequest();
    musiciansFutureRequest = musicianRequest.getMusicians(highlighted: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: musiciansFutureRequest,
      builder: (context, musicianSnapshot) {
        if (musicianSnapshot.hasData) {
          List<Widget> musicians = [];
          for (Musician? musician in (musicianSnapshot.data?.result ?? [])) {
            musicians.add(MusicianCard(
              musician: musician,
            ));
          }
          return Column(
            children: musicians,
          );
        } else {
          return CircularLoader(color: AppColors.primaryColor, size: 50);
        }
      },
    );
  }
}

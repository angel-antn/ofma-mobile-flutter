import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/data/remote/ofma/musician_request.dart';
import 'package:ofma_app/models/musician.response.dart';
import 'package:ofma_app/utils/to_title_case.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MusicianScreen extends StatefulWidget {
  const MusicianScreen({super.key, required this.id});

  final String id;

  @override
  State<MusicianScreen> createState() => _MusicianScreenState();
}

class _MusicianScreenState extends State<MusicianScreen> {
  late Future<Musician?> musicianFutureRequest;

  @override
  void initState() {
    final musicianRequest = MusicianRequest();
    musicianFutureRequest = musicianRequest.getMusicianById(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: FutureBuilder(
          future: musicianFutureRequest,
          builder: (BuildContext context,
              AsyncSnapshot<Musician?> musicianSnapshot) {
            return _MusicianPage(
              connectionState: musicianSnapshot.connectionState,
              musician: musicianSnapshot.data,
            );
          },
        ),
      ),
    );
  }
}

class _MusicianPage extends StatelessWidget {
  const _MusicianPage({this.musician, required this.connectionState});

  final Musician? musician;
  final ConnectionState connectionState;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: musician == null || connectionState != ConnectionState.done,
        child: SingleChildScrollView(
          child: Stack(children: [
            _MusicianHeader(musician: musician),
            _MusicianBody(musician: musician)
          ]),
        ));
  }
}

class _MusicianBody extends StatelessWidget {
  const _MusicianBody({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 350),
      child: Column(
        children: [
          _MusicianInfoCard(
            text: musician?.description ?? 'Lorem ipsum ' * 10,
            title: 'Descripción',
            icon: Icons.format_indent_increase,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: _MusicianInfoCard(
                text:
                    '${musician?.birthdate?.day ?? 0}/${musician?.birthdate?.month ?? 0}/${musician?.birthdate?.year ?? 0}',
                title: 'Nacimiento',
                icon: CommunityMaterialIcons.account_outline,
              )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: _MusicianInfoCard(
                text:
                    '${musician?.startDate?.day ?? 0}/${musician?.startDate?.month ?? 0}/${musician?.startDate?.year ?? 0}',
                title: 'Inscripción',
                icon: CommunityMaterialIcons.calendar_range_outline,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _MusicianInfoCard extends StatelessWidget {
  const _MusicianInfoCard({
    required this.text,
    required this.icon,
    required this.title,
  });

  final String text;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5), color: Colors.black12, blurRadius: 15)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(title),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}

class _MusicianHeader extends StatelessWidget {
  const _MusicianHeader({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
            height: 410,
            width: double.infinity,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(25)),
              child: Image.asset(
                'assets/backgrounds/musician_background.webp',
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          top: 40,
          left: 30,
          child: TouchableOpacity(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
        Column(children: [
          const SizedBox(
            height: 50,
          ),
          _MusicianHeaderImage(musician: musician),
          const SizedBox(
            height: 10,
          ),
          _MusicianHeaderName(musician: musician),
          const SizedBox(
            height: 5,
          ),
          _MusicianSubtitle(musician: musician),
          const SizedBox(
            height: 13,
          ),
          _MusicianHeaderInfo(musician: musician)
        ])
      ],
    );
  }
}

class _MusicianSubtitle extends StatelessWidget {
  const _MusicianSubtitle({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Text(
        musician?.isHighlighted ?? false ? 'Músico destacado' : 'Músico',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _MusicianHeaderName extends StatelessWidget {
  const _MusicianHeaderName({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          toTitleCase(musician?.fullname ?? 'Lorem Ipsum'),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        if (musician?.isHighlighted ?? false)
          const SizedBox(
            width: 10,
          ),
        if (musician?.isHighlighted ?? false)
          const Icon(
            CommunityMaterialIcons.star_shooting_outline,
            color: Colors.white,
          )
      ],
    );
  }
}

class _MusicianHeaderImage extends StatelessWidget {
  const _MusicianHeaderImage({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: CircleAvatar(
        foregroundImage: NetworkImage(
          (musician?.imageUrl ??
                  'https://images.unsplash.com/photo-1511379938547-c1f69419868d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
              .replaceAll(
            'localhost',
            (dotenv.env['LOCALHOST_ENVIRON'] ?? ''),
          ),
        ),
      ),
    );
  }
}

class _MusicianHeaderInfo extends StatelessWidget {
  const _MusicianHeaderInfo({
    required this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MusicianHeaderCounter(
          text: 'Conciertos',
          counter: (musician?.concertCount ?? '0'),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        _MusicianHeaderCounter(
          text: 'Contenido',
          counter: (musician?.exclusiveContentCount ?? '0'),
        ),
      ],
    );
  }
}

class _MusicianHeaderCounter extends StatelessWidget {
  const _MusicianHeaderCounter({
    required this.text,
    required this.counter,
  });

  final String counter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          counter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

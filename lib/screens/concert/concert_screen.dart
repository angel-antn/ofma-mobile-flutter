import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/data/remote/ofma/concert_request.dart';
import 'package:ofma_app/models/concert_response.dart';
import 'package:ofma_app/screens/concert/pages/concert_booking_page.dart';
import 'package:ofma_app/screens/concert/pages/concert_details_page.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/convert_to_12_hour_format.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ConcertScreen extends StatefulWidget {
  const ConcertScreen({super.key, required this.id});

  final String id;

  @override
  State<ConcertScreen> createState() => _ConcertScreenState();
}

class _ConcertScreenState extends State<ConcertScreen> {
  late ValueNotifier<Future<Concert?>> concertNotifier;
  @override
  void initState() {
    final concertRequest = ConcertRequest();
    concertNotifier = ValueNotifier<Future<Concert?>>(
        concertRequest.getConcertById(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setConcert() {
      final concertRequest = ConcertRequest();
      concertNotifier.value =
          Future(() => concertRequest.getConcertById(widget.id));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
          valueListenable: concertNotifier,
          builder: (context, value, child) {
            return FutureBuilder(
              future: value,
              builder: (context, concertSnapshot) {
                return _ConcertPage(
                    concert: concertSnapshot.data,
                    setConcert: setConcert,
                    connectionState: concertSnapshot.connectionState);
              },
            );
          }),
    );
  }
}

class _ConcertPage extends StatelessWidget {
  const _ConcertPage(
      {this.concert, required this.setConcert, required this.connectionState});

  final Concert? concert;
  final Function setConcert;
  final ConnectionState connectionState;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignoreContainers: true,
      enabled: concert == null || connectionState != ConnectionState.done,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            _ConcertHeader(concert: concert),
            _ConcertBody(
              concert: concert,
              setConcert: setConcert,
            )
          ],
        ),
      ),
    );
  }
}

class _ConcertBody extends StatefulWidget {
  const _ConcertBody({
    required this.concert,
    required this.setConcert,
  });

  final Concert? concert;
  final Function setConcert;

  @override
  State<_ConcertBody> createState() => _ConcertBodyState();
}

class _ConcertBodyState extends State<_ConcertBody> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 280),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _IndexButton(
                    index: 0,
                    currentIndex: currentIndex,
                    text: 'Descripción',
                    icon: Icons.info_outline,
                    onTap: () => setState(() {
                      currentIndex = 0;
                    }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _IndexButton(
                    index: 1,
                    currentIndex: currentIndex,
                    text: 'Comprar boletos',
                    icon: CommunityMaterialIcons.ticket_confirmation_outline,
                    onTap: () => setState(() {
                      currentIndex = 1;
                    }),
                  )
                ]),
          ),
          const SizedBox(
            height: 30,
          ),
          if (currentIndex == 0) ConcertDetailsPage(concert: widget.concert),
          if (currentIndex == 1)
            ConcertBookingPage(
              concert: widget.concert,
              setConcert: widget.setConcert,
            )
        ],
      ),
    );
  }
}

class _IndexButton extends StatelessWidget {
  const _IndexButton(
      {required this.index,
      required this.currentIndex,
      required this.text,
      required this.icon,
      required this.onTap});

  final int index;
  final int currentIndex;
  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TouchableOpacity(
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Easing.emphasizedDecelerate,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: index == currentIndex
                  ? AppColors.secondaryColor
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: index == currentIndex ? Colors.white : Colors.black26,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  color: index == currentIndex ? Colors.white : Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ConcertHeader extends StatelessWidget {
  const _ConcertHeader({
    required this.concert,
  });

  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          (concert?.imageUrl ??
                  'https://images.unsplash.com/photo-1465847899084-d164df4dedc6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
              .replaceAll(
            'localhost',
            (dotenv.env['LOCALHOST_ENVIRON'] ?? ''),
          ),
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.purple[900]!.withAlpha(150),
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.black54,
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                TouchableOpacity(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  concert?.name ?? 'Lorem ipsum',
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.calendar_range_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${concert?.startDate?.day}/${concert?.startDate?.month}/${concert?.startDate?.year}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ]),
                const SizedBox(
                  height: 5,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.clock_time_eleven_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    convertTo12HourFormat(concert?.startAtHour ?? '00:00:00'),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ]),
                const SizedBox(
                  height: 5,
                ),
                Row(children: [
                  const Icon(
                    CommunityMaterialIcons.map_marker_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    concert?.address ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}

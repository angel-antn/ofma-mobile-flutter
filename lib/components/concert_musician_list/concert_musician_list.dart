import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/models/concert_response.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/utils/to_title_case.dart';

class ConcertMusiciansList extends StatelessWidget {
  const ConcertMusiciansList({
    super.key,
    required this.musicians,
  });

  final List<ConcertMusician?> musicians;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 0.3),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.all(Radius.circular(3))),
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
              'Músicos presentes',
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
          height: 20,
        ),
        Builder(
          builder: (context) {
            List<Widget> musicians = [];
            for (dynamic musician in this.musicians) {
              musicians.add(_ConcertMusicianCard(
                musician: musician,
              ));
            }
            return Column(
              children: musicians,
            );
          },
        ),
      ],
    );
  }
}

class _ConcertMusicianCard extends StatelessWidget {
  const _ConcertMusicianCard({
    this.musician,
  });

  final ConcertMusician? musician;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => context.pushNamed(AppRouterConstants.musicianScreen,
          pathParameters: {"id": musician?.musicianId ?? ''}),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 3,
              )
            ]),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    (musician?.imageUrl ?? '').replaceAll(
                      'localhost',
                      (dotenv.env['LOCALHOST_ENVIRON'] ?? ''),
                    ),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          toTitleCase(
                            musician?.fullname ?? '',
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Row(
                          children: [
                            const Icon(
                              FeatherIcons.alignLeft,
                              size: 16,
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Como ${musician?.role ?? 'músico'}',
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12)),
                child: const Icon(
                  FeatherIcons.music,
                  color: Colors.black12,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

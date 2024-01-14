import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/models/musician.response.dart';
import 'package:ofma_app/utils/to_title_case.dart';

class MusicianCard extends StatelessWidget {
  const MusicianCard({
    super.key,
    this.musician,
  });

  final Musician? musician;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  (musician?.imageUrl ?? '')
                      .replaceAll('localhost', '10.0.2.2'),
                  fit: BoxFit.cover,
                  width: 140,
                  height: 140,
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
                            'Miembro desde ${musician?.startDate?.year ?? "????"}',
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
          if (musician?.isHighlighted ?? false)
            Positioned(
              bottom: 0,
              child: Container(
                height: 30,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Text('Destacado'),
              ),
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
    );
  }
}

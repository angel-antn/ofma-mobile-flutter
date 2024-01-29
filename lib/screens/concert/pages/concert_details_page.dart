import 'package:flutter/material.dart';
import 'package:ofma_app/components/concert_musician_list/concert_musician_list.dart';
import 'package:ofma_app/models/concert_response.dart';

class ConcertDetailsPage extends StatelessWidget {
  const ConcertDetailsPage({
    super.key,
    this.concert,
  });

  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          concert?.name ?? 'Lorem ipsum',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Text(
          concert?.description ?? 'lorem ipsum sit amet dolore' * 40,
        ),
        const SizedBox(
          height: 20,
        ),
        ConcertMusiciansList(musicians: concert?.concertMusician ?? [])
      ],
    );
  }
}

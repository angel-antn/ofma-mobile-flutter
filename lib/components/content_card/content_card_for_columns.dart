import 'package:flutter/material.dart';
import 'package:ofma_app/models/content_response.dart';
import 'package:ofma_app/utils/to_title_case.dart';

class ContentCardForColumns extends StatelessWidget {
  const ContentCardForColumns(
      {super.key, required this.color, required this.category, this.content});

  final Color color;
  final String category;
  final Content? content;

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
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Stack(
          children: [
            Image.network(
              (content?.imageUrl ?? '').replaceAll('localhost', '10.0.2.2'),
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: 180,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: color.withAlpha(200),
                ),
                height: 50,
                width: double.maxFinite,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3))),
                      child: Text(
                        toTitleCase(category),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        content?.name ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
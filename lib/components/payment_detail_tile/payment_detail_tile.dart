import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text('$title:'),
          ],
        ),
        SelectableText(body)
      ],
    );
  }
}

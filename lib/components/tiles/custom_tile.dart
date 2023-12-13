import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
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
    return TouchableOpacity(
      onTap: () => onTap(),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 50,
            height: 47,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 17,
          ),
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          )),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}

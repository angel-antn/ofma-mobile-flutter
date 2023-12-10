import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.width,
      required this.onTap,
      required this.text,
      this.isLoading = false});

  final double width;
  final Function onTap;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final buttonDecoration = BoxDecoration(
      color: AppColors.secondaryColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    );

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return TouchableOpacity(
      child: Container(
        width: width,
        height: 55,
        decoration: buttonDecoration,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: textStyle,
                ),
        ),
      ),
      onTap: () => onTap(),
    );
  }
}

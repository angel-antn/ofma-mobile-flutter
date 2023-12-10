import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/touchable_opacity.dart';
import 'package:ofma_app/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
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
      border: Border.all(color: AppColors.secondaryColor, width: 3),
      color: AppColors.lessTranslucentWhite,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
    );

    final textStyle = TextStyle(
      color: AppColors.secondaryColor,
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
              ? CircularProgressIndicator(
                  color: AppColors.secondaryColor,
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

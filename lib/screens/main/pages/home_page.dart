import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: SvgPicture.asset(
          'assets/logo/ofma_logo.svg',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Preferences.clear();
            context.pushReplacementNamed(AppRouterConstants.loginScreen);
          },
          child: const Text('Cerrar'),
        ),
      ),
    );
  }
}

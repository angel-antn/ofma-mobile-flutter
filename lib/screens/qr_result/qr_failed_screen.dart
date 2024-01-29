import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofma_app/theme/app_colors.dart';

class QRFailedScreen extends StatelessWidget {
  const QRFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        _FailedQRBackground(),
        _FailedQRBody(),
      ],
    ));
  }
}

class _FailedQRBackground extends StatelessWidget {
  const _FailedQRBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Image.asset(
        'assets/backgrounds/failed_payment_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _FailedQRBody extends StatelessWidget {
  const _FailedQRBody();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              SpinKitDoubleBounce(
                color: AppColors.red,
                size: 150,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white12),
                child: const Icon(
                  FeatherIcons.xCircle,
                  color: Colors.white,
                  size: 70,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'El boleto no es válido',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Lamentamos mucho lo sucedido',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Verifique si el boleto no se ha usado',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          const Text('o reinténtalo de nuevo más tarde',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      ),
    ));
  }
}

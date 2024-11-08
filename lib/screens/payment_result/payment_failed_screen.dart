import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        _FailedPaymentBackground(),
        _FailedPaymentBody(),
      ],
    ));
  }
}

class _FailedPaymentBackground extends StatelessWidget {
  const _FailedPaymentBackground();

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

class _FailedPaymentBody extends StatelessWidget {
  const _FailedPaymentBody();

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
            'Error registrar el pago',
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
          const Text('Puede contactar a soporte o',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          const Text('reinténtalo de nuevo más tarde',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      ),
    ));
  }
}

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofma_app/theme/app_colors.dart';

class PaymentConfirmedScreen extends StatelessWidget {
  const PaymentConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        _ConfirmedPaymentBackground(),
        _ConfirmedPaymentBody(),
      ],
    ));
  }
}

class _ConfirmedPaymentBackground extends StatelessWidget {
  const _ConfirmedPaymentBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Image.asset(
        'assets/backgrounds/confirmed_payment_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ConfirmedPaymentBody extends StatelessWidget {
  const _ConfirmedPaymentBody();

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
                color: AppColors.green,
                size: 150,
              ),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white12),
                child: const Icon(
                  FeatherIcons.checkCircle,
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
            '¡Pago registrado con exito!',
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
            'Muchas gracias por su compra',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Puede revisar el estatus de su orden',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          const Text('en la seccion de ver órdenes',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      ),
    ));
  }
}

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ofma_app/models/use_ticket_response.dart';
import 'package:ofma_app/theme/app_colors.dart';

class QRConfirmedScreen extends StatelessWidget {
  const QRConfirmedScreen({super.key, required this.useTicketResponse});

  final UseTicketResponse useTicketResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const _QrConfirmedBackground(),
        _QRConfirmedBody(
          useTicketResponse: useTicketResponse,
        ),
      ],
    ));
  }
}

class _QrConfirmedBackground extends StatelessWidget {
  const _QrConfirmedBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Image.asset(
        'assets/backgrounds/confirmed_ticket_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _QRConfirmedBody extends StatelessWidget {
  const _QRConfirmedBody({required this.useTicketResponse});

  final UseTicketResponse useTicketResponse;

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
                color: AppColors.purple,
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
            '¡Boleto escaneado!',
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
            'El boleto escaneado es válido',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const Text(
            'para el concierto:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Esperamos disfrute el concierto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          const Text('que hemos preparado para usted',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      ),
    ));
  }
}

import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:community_material_icon/community_material_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/border_painter/border_painter.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/fields/custom_text_field.dart';
import 'package:ofma_app/data/remote/ofma/ticket_request.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:ofma_app/utils/is_valid_uuid.dart';

qrScan(BuildContext context) async {
  if (await Permission.camera.request().isGranted &&
      await Permission.storage.request().isGranted) {
    try {
      String value = await scanner.scan() ?? '';
      SchedulerBinding.instance.addPostFrameCallback((_) {
        validateCode(value, context);
      });
    } catch (_) {
      Fluttertoast.showToast(
          msg: 'Código no válido', backgroundColor: Colors.grey);
    }
  }
}

qrPhoto(BuildContext context) async {
  if (await Permission.camera.request().isGranted &&
      await Permission.storage.request().isGranted) {
    try {
      String value = await scanner.scanPhoto();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        validateCode(value, context);
      });
    } catch (_) {
      Fluttertoast.showToast(
          msg: 'Código no válido', backgroundColor: Colors.grey);
    }
  }
}

validateCode(String value, BuildContext context) {
  if (isValidUUID(value)) {
    final ticketRequest = TicketRequest();
    context.pushNamed(AppRouterConstants.qRLoadingScreen,
        extra: ticketRequest.useTicket(value));
  } else {
    Fluttertoast.showToast(
        msg: 'Código no válido', backgroundColor: Colors.grey);
  }
}

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Revisar QRs')),
      body: Stack(
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(25)),
              child: Image.asset(
                'assets/backgrounds/qr_scanner_background.webp',
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          const _QRScannerBody(),
        ],
      ),
    );
  }
}

class _QRScannerBody extends StatelessWidget {
  const _QRScannerBody();

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 15)
        ]);
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _QRImageCard(boxDecoration: boxDecoration),
            SizedBox(
              height: 20,
            ),
            _QRSearchCard(boxDecoration: boxDecoration),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _QRSearchCard extends StatelessWidget {
  const _QRSearchCard({
    required this.boxDecoration,
  });

  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: boxDecoration,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('O ingresa el código asociado debajo'),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            textEditingController: textEditingController,
            hintText: 'Código asociado',
            icon: FeatherIcons.search,
            onSubmit: (value) {
              validateCode(value, context);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          PrimaryButton(
              width: double.infinity,
              onTap: () {
                final String value = textEditingController.text;
                validateCode(value, context);
              },
              text: 'Verificar código')
        ],
      ),
    );
  }
}

class _QRImageCard extends StatelessWidget {
  const _QRImageCard({
    required this.boxDecoration,
  });

  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: boxDecoration,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('Alinea el código QR dentro del marco'),
          const Text('para escanearlo'),
          const SizedBox(
            height: 20,
          ),
          const _QRImage(),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Elija cómo escanear el código QR'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          width: double.maxFinite,
                          onTap: () => qrScan(context),
                          text: 'Cámara'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: PrimaryButton(
                          width: double.maxFinite,
                          onTap: () => qrPhoto(context),
                          text: 'Galería'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QRImage extends StatelessWidget {
  const _QRImage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BorderPainter(color: AppColors.lightBlue, thickness: 8.0),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Icon(
            CommunityMaterialIcons.qrcode,
            size: 180,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}

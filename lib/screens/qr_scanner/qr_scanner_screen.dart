import 'package:community_material_icon/community_material_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/components/fields/custom_text_form_field.dart';
import 'package:ofma_app/theme/app_colors.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const _QRImageCard(boxDecoration: boxDecoration),
            const SizedBox(
              height: 20,
            ),
            const _QRSearchCard(boxDecoration: boxDecoration),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
                width: double.maxFinite,
                onTap: () {},
                text: 'Empezar a escanear'),
            const SizedBox(
              height: 20,
            )
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
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20),
      decoration: boxDecoration,
      child: const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('O ingresa el codigo asociado debajo'),
          SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              hintText: 'Código asociado', icon: FeatherIcons.search)
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
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Alinea el código QR dentro del marco'),
          Text('para escanearlo'),
          SizedBox(
            height: 20,
          ),
          _QRImage(),
          SizedBox(
            height: 30,
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
        painter: _BorderPainter(),
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

class _BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 8.0;
    const radius = 20.0;
    const tRadius = 2 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppColors.lightBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

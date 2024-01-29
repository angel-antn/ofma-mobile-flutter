import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/use_ticket_response.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:provider/provider.dart';

class QRLoadingScreen extends StatefulWidget {
  const QRLoadingScreen({super.key, required this.useTicketFutureRequest});
  final Future<UseTicketResponse?> useTicketFutureRequest;

  @override
  State<QRLoadingScreen> createState() => _QRLoadingScreenState();
}

class _QRLoadingScreenState extends State<QRLoadingScreen> {
  late Future<UseTicketResponse?> useTicketFutureRequest;

  @override
  void initState() {
    useTicketFutureRequest = widget.useTicketFutureRequest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return PopScope(
      canPop: false,
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          body: FutureBuilder(
              future: useTicketFutureRequest,
              builder: (context, ticketSnapshot) {
                if (ticketSnapshot.connectionState == ConnectionState.done) {
                  if (ticketSnapshot.hasError || !ticketSnapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        context.pushReplacementNamed(
                            AppRouterConstants.qRFailedScreen);
                      },
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        userDataProvider.updateUser(Preferences.user!);
                        context.pushReplacementNamed(
                            AppRouterConstants.qRConfirmedScreen,
                            extra: ticketSnapshot.data);
                      },
                    );
                  }
                }
                return const Stack(
                  children: [
                    _QRLoadingBackground(),
                    _QRLoadingBody(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _QRLoadingBody extends StatelessWidget {
  const _QRLoadingBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitRipple(
          color: Colors.white,
          size: 120,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Validando QR',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Espere un momento mientras válidamos',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          'el códido',
          style: TextStyle(fontSize: 16, color: Colors.white),
        )
      ],
    );
  }
}

class _QRLoadingBackground extends StatelessWidget {
  const _QRLoadingBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Image.asset(
        'assets/backgrounds/confirm_payment_background.webp',
        fit: BoxFit.cover,
      ),
    );
  }
}

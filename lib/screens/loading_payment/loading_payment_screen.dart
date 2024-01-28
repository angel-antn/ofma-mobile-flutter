import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/data/local/preferences.dart';
import 'package:ofma_app/models/orders_response.dart';
import 'package:ofma_app/providers/user_data_provider.dart';
import 'package:ofma_app/router/router_const.dart';
import 'package:provider/provider.dart';

class LoadingPaymentScreen extends StatefulWidget {
  const LoadingPaymentScreen(
      {super.key, required this.createOrderFutureRequest});
  final Future<Order?> createOrderFutureRequest;

  @override
  State<LoadingPaymentScreen> createState() => _LoadingPaymentScreenState();
}

class _LoadingPaymentScreenState extends State<LoadingPaymentScreen> {
  late Future<Order?> createOrderFutureRequest;

  @override
  void initState() {
    createOrderFutureRequest = widget.createOrderFutureRequest;
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
              future: createOrderFutureRequest,
              builder: (context, orderSnapshot) {
                if (orderSnapshot.connectionState == ConnectionState.done) {
                  if (orderSnapshot.hasError || !orderSnapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        context.pushReplacementNamed(
                            AppRouterConstants.paymentFailedScreen);
                      },
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        userDataProvider.updateUser(Preferences.user!);
                        context.pushReplacementNamed(
                            AppRouterConstants.paymentConfirmedScreen);
                      },
                    );
                  }
                }
                return const Stack(
                  children: [
                    _LoadingPaymentBackground(),
                    _LoadingPaymentBody(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _LoadingPaymentBody extends StatelessWidget {
  const _LoadingPaymentBody();

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
          'Procesando pago',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Espere un momento mientras procesamos',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          'la orden de pago',
          style: TextStyle(fontSize: 16, color: Colors.white),
        )
      ],
    );
  }
}

class _LoadingPaymentBackground extends StatelessWidget {
  const _LoadingPaymentBackground();

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

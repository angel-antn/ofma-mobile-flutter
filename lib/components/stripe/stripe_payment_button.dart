import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/data/remote/ofma/orders_request.dart';
import 'package:ofma_app/data/remote/ofma/stripe_request.dart';
import 'package:ofma_app/models/payment_params.dart';
import 'package:ofma_app/router/router_const.dart';

class StripePaymentButton extends StatelessWidget {
  const StripePaymentButton(
      {super.key,
      required this.width,
      required this.text,
      required this.amount,
      required this.paymentParams});

  final double width;
  final String text;
  final double amount;
  final PaymentParams paymentParams;

  @override
  Widget build(BuildContext context) {
    makePayment() async {
      final stripeRequest = StripeRequest();

      try {
        final paymentIntentAndCustomer =
            await stripeRequest.getPaymentIntentAndCustomer(amount: amount);
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntentAndCustomer?.clientSecret ?? '',
              style: ThemeMode.light,
              merchantDisplayName: 'OFMA app'),
        );
        await Stripe.instance.presentPaymentSheet();

        final orderRequest = OrderRequest();
        final createOrderFutureRequest = orderRequest.createOrder(
            reference: paymentIntentAndCustomer!.paymentIntentId!,
            paidAt: DateTime.now(),
            paymentParams: paymentParams);

        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.pushReplacementNamed(AppRouterConstants.loadingPaymentScreen,
              extra: createOrderFutureRequest);
        });
      } catch (_) {
        Fluttertoast.showToast(
            msg: 'No se ha podido procesar el pago',
            backgroundColor: Colors.grey);
      }
    }

    return PrimaryButton(
      width: width,
      onTap: () => makePayment(),
      text: text,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ofma_app/components/buttons/primary_button.dart';
import 'package:ofma_app/data/remote/ofma/stripe_request.dart';

class StripePaymentButton extends StatelessWidget {
  const StripePaymentButton(
      {super.key,
      required this.width,
      required this.text,
      required this.amount});

  final double width;
  final String text;
  final double amount;

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

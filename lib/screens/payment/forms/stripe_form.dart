import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ofma_app/components/payment_form_title/payment_form_title.dart';
import 'package:ofma_app/components/stripe/stripe_payment_button.dart';

class StripeForm extends StatelessWidget {
  const StripeForm({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentFormTitle(
          title: 'Validar pago',
          amount: amount,
        ),
        const SizedBox(
          height: 40,
        ),
        SvgPicture.asset(
          'assets/images/credit_card.svg',
          height: 150,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Las órdenes de pago realizadas con',
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
        const Text(
          'tarjeta de crédito o débito son verificadas',
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
        const Text(
          'desde el momento que efectuas el pago',
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
        const SizedBox(
          height: 30,
        ),
        StripePaymentButton(
          width: double.infinity,
          text: 'Siguiente',
          amount: amount,
        )
      ],
    );
  }
}

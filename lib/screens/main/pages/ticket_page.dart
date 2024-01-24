import 'package:flutter/material.dart';
import 'package:ofma_app/components/stripe/stripe_payment_button.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Boletos')),
      body: const Column(
        children: [
          StripePaymentButton(
            amount: 43.3333,
            text: 'pagar',
            width: 300,
          )
        ],
      ),
    );
  }
}
